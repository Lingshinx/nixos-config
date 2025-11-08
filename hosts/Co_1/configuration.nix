{
  my_hosts,
  pkgs,
  ...
}: let
  host1 = my_hosts.Co_1.hostName;
in {
  imports = [
    ./hardware-configuration.nix
    ../reusable.nix
    (import ../reusable/my_host.nix {hostName = host1;})
  ];
}
