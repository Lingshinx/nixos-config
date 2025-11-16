{my_hosts, ...}: let
  host1 = my_hosts.pc_1.hostName;
in {
  imports = [
    ./hardware-configuration.nix
    ../reusable.nix
    (import ../reusable/my_host.nix {hostName = host1;})
  ];

  services.tailscale = {
    enable = false;
    useRoutingFeatures = "client";
    extraUpFlags = ["--accept-dns=true"];
  };
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_NO_DNS=1"
  ];
}
