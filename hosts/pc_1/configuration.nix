{ my_hosts, lib, ... }:
let
  host1 = my_hosts.pc_1.hostName;
in
{
  imports = [
    ./hardware-configuration.nix
    ../reusable.nix
    (import ../reusable/my_host.nix { hostName = host1; })
  ];

  services = {
    tailscale.enable = true;
  };

  networking = {
    hosts = {
      "127.0.0.1" = lib.mkAfter [
        "nixos"
      ];
    };

  };
}
