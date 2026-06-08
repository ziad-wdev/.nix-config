{
  # Configure the network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Configure bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Optimize network performance
  boot.kernel.sysctl = {
    # Use BBR congestion control with CAKE qdisc
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";

    # Enable TCP Fast Open
    "net.ipv4.tcp_fastopen" = 3;

    # Increase TCP buffer sizes
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";

    # Enable MTU probing for black hole routers
    "net.ipv4.tcp_mtu_probing" = 1;

    # Disable TCP slow start after idle
    "net.ipv4.tcp_slow_start_after_idle" = 0;

    # Enable Explicit Congestion Notification (ECN)
    "net.ipv4.tcp_ecn" = 1;

    # Tune TCP keepalive for faster dead connection detection
    "net.ipv4.tcp_keepalive_time" = 60;
    "net.ipv4.tcp_keepalive_intvl" = 10;
    "net.ipv4.tcp_keepalive_probes" = 6;
  };
  # Enable local DNS caching
  services.resolved.enable = true;
}
