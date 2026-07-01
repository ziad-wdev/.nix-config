{pkgs, ...}: {
  systemd.services.daily-network-quota = {
    description = "Apply and reset daily 2.5GB network quota for WiFi and Ethernet";
    path = [pkgs.iptables pkgs.iproute2 pkgs.gnugrep pkgs.gawk];
    wantedBy = ["multi-user.target"];

    script = ''
      BYTES="2684354560"  # 2.5 GB in bytes

      # 1. Create the custom quota chain if it doesn't exist
      iptables -N DAILY_QUOTA 2>/dev/null || true

      # 2. Find all Ethernet (en*) and WiFi (wl*) interfaces on this machine
      INTERFACES=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^(en|wl)')

      # 3. Bind the quota chain to every detected interface
      for INTERFACE in $INTERFACES; do
        iptables -C OUTPUT -o "$INTERFACE" -j DAILY_QUOTA 2>/dev/null || iptables -A OUTPUT -o "$INTERFACE" -j DAILY_QUOTA
      done

      # 4. Flush old counters and apply the global 2.5GB limit
      iptables -F DAILY_QUOTA
      iptables -A DAILY_QUOTA -m quota --quota "$BYTES" -j RETURN
      iptables -A DAILY_QUOTA -j DROP
    '';
  };

  systemd.timers.daily-network-quota = {
    description = "Trigger network quota reset at midnight";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "00:00:00";
      Persistent = true;
    };
  };
}
