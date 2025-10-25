{ config, pkgs, ... }:

{
  # 启用 ssh-agent（便于签名与认证）
  programs.ssh = {
    enable = true;
    # 关键：关闭未来将废弃的默认配置
    enableDefaultConfig = false;
    # 如果你需要保留一些默认值，可以自己写在这里
    matchBlocks."*" = {
      forwardAgent = true;
      serverAliveInterval = 60;
    };
  };

  services.ssh-agent.enable = true;
}