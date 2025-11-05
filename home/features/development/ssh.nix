{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # 用 matchBlocks 声明配置
    matchBlocks."github.com" = {
      user = "git";
      identityFile = ["~/.ssh/id_ed25519"];
      identitiesOnly = true;
      serverAliveInterval = 60;
      serverAliveCountMax = 3;
      forwardAgent = true;
    };

    # 全局配置（可选）
    matchBlocks."*" = {
      forwardAgent = true;
      serverAliveInterval = 60;
    };
  };

  services.ssh-agent.enable = true;
}
