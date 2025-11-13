# my_host.nix
{hostName}: {
  # 开启 systemd-resolved
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    fallbackDns = ["1.1.1.1" "8.8.8.8" "233.5.5.5"];
  };
  #  # 让 tailscale0 接口只负责 ts.net 域名
  systemd.network.networks."50-tailscale" = {
    matchConfig.Name = "tailscale0";
    networkConfig.DNS = ["100.100.100.100"]; # tailscale 内置 DNS
    domains = ["~ts.net"]; # 只匹配 ts.net 域名
  };
  networking = {
    nameservers = ["1.1.1.1" "8.8.8.8" "233.5.5.5"];
    firewall.allowedTCPPorts = [4001];
    firewall.allowedTCPPortRanges = [
      {
        from = 3000;
        to = 4000;
      }
    ];
    resolvconf.enable = false;
    hostName = hostName;
    hosts = {
      "127.0.0.1" = [
        "localhost"
        hostName
      ];
      "::1" = [
        "localhost"
        hostName
      ];
    };
  };
}
