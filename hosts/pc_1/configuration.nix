{ my_hosts, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../reusable.nix
  ];

  services = {
    tailscale.enable = true;
  };

  networking = {
    hostName = my_hosts.pc_1.hostName;
    # 禁用自动添加 127.0.0.2 条目
    extraHosts = ''
      127.0.0.1 localhost ${my_hosts.pc_1.hostName}
      ::1       localhost
    '';
  };
}
