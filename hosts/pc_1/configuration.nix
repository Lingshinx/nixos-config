{ my_hosts, ... }:
let
  host1 = my_hosts.pc_1.hostName;
in
{
  imports = [
    ./hardware-configuration.nix
    ../reusable.nix
  ];

  services = {
    tailscale.enable = true;
  };

  networking = {
    hostName = host1;
    # 禁用自动添加 127.0.0.2 条目
    extraHosts = ''
      127.0.0.1 localhost ${host1}
      ::1       localhost ${host1}
    '';
  };
}
