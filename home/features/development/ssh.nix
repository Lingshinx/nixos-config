{ pkgs, ... }:

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

  home.activation.postActivation = ''
    if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
      echo "Generating SSH key for user $USER..."
      mkdir -p "$HOME/.ssh"
      chmod 700 "$HOME/.ssh"
      ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" -C "$USER@$( ${pkgs.hostname}/bin/hostname )"
    fi
  '';

}
