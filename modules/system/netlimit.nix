{pkgs, ...}: {
  # 1. Main service that manages, saves, and loads the quota state
  systemd.services.daily-network-quota = {
    description = "Apply and persist daily 2.5GB network quota";
    path = [pkgs.iptables pkgs.iproute2 pkgs.gnugrep pkgs.gawk pkgs.coreutils];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true; # Keeps the service "active" so it can intercept shutdown
    };

    # What happens on Boot
    script = ''
      STATE_DIR="/var/lib/daily-network-quota"
      STATE_FILE="$STATE_DIR/state"
      mkdir -p "$STATE_DIR"

      CURRENT_DATE=$(date +%Y-%m-%d)
      BYTES="2684354560" # Default 2.5 GB

      # If a state file exists and it belongs to TODAY, restore the remaining bytes
      if [ -f "$STATE_FILE" ]; then
        read -r SAVED_DATE SAVED_BYTES < "$STATE_FILE"
        if [ "$SAVED_DATE" = "$CURRENT_DATE" ] && [[ "$SAVED_BYTES" =~ ^[0-9]+$ ]]; then
          BYTES="$SAVED_BYTES"
        fi
      fi

      # Set up the iptables rules
      iptables -N DAILY_QUOTA 2>/dev/null || true
      INTERFACES=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^(en|wl)')
      for IFACE in $INTERFACES; do
        iptables -C INPUT -i "$IFACE" -j DAILY_QUOTA 2>/dev/null || iptables -A INPUT -i "$IFACE" -j DAILY_QUOTA
        iptables -C OUTPUT -o "$IFACE" -j DAILY_QUOTA 2>/dev/null || iptables -A OUTPUT -o "$IFACE" -j DAILY_QUOTA
      done

      iptables -F DAILY_QUOTA
      iptables -A DAILY_QUOTA -m quota --quota "$BYTES" -j RETURN
      iptables -A DAILY_QUOTA -j DROP

      # Ensure the state file is written with current progress
      echo "$CURRENT_DATE $BYTES" > "$STATE_FILE"
    '';

    # What happens on Shutdown / Reboot
    preStop = ''
      STATE_FILE="/var/lib/daily-network-quota/state"
      CURRENT_DATE=$(date +%Y-%m-%d)

      # Extract the exact remaining bytes from the live iptables counter
      REMAINING=$(iptables -L DAILY_QUOTA -v -n 2>/dev/null | grep -oE 'quota: [0-9]+' | awk '{print $2}')

      # If we successfully read a number, save it to disk
      if [[ "$REMAINING" =~ ^[0-9]+$ ]]; then
        echo "$CURRENT_DATE $REMAINING" > "$STATE_FILE"
      fi
    '';
  };

  # 2. A mini-service to clear state and refresh at midnight
  systemd.services.daily-network-quota-reset = {
    description = "Reset daily network quota state at midnight";
    path = [pkgs.coreutils pkgs.systemd];
    script = ''
      rm -f /var/lib/daily-network-quota/state
      systemctl restart daily-network-quota.service
    '';
  };

  # 3. The timer that coordinates the midnight reset
  systemd.timers.daily-network-quota-reset = {
    description = "Trigger network quota reset at midnight";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "00:00:00";
      Persistent = true;
      Unit = "daily-network-quota-reset.service";
    };
  };
}
