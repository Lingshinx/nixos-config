# home.nix
{
  config,
  pkgs,
  lib,
  vicinaeModule,
  dankMaterialShell,
  niri,
  ...
}:

{
  home.username = "yb";
  home.homeDirectory = "/home/yb";
  home.stateVersion = "25.11";

  imports = [
    dankMaterialShell.homeModules.dankMaterialShell.default
    dankMaterialShell.homeModules.dankMaterialShell.niri
    niri.homeModules.niri
    vicinaeModule
  ];
  # 启用 ssh-agent（便于签名与认证）
  programs.ssh = {
    enable = true;
  };
  services.ssh-agent.enable = true;

  # Git 全局配置（用户级）
  programs.git = {
    enable = true;
    userName = "yb";
    userEmail = "scauyb@qq.com";

    extraConfig = {
      gpg.format = "ssh";
      user.signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
      gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
      url."git@github.com:".insteadOf = "https://github.com/";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
    };
  };

  programs.dankMaterialShell.enable = true;

  home.activation.postActivation = ''
    if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
      echo "Generating SSH key for user $USER..."
      mkdir -p "$HOME/.ssh"
      chmod 700 "$HOME/.ssh"
      ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" -C "$USER@$( ${pkgs.hostname}/bin/hostname )"
    fi
  '';

  #programs.niri.enable = true;

  home.packages = with pkgs; [
    miniserve
    docker-compose
    davfs2
    rclone
    tailscale
    fcitx5-configtool
    libinput
    openssh
    hostname
    rustscan
    fastfetch
    bottom
    qq
    atuin
    starship
    zoxide
    bat
    jetbrains.rust-rover
    jetbrains.webstorm
    telegram-desktop_git
    netease-cloud-music-gtk
    gnome-keyring
    vscode
    nixfmt-rfc-style

  ];
  services.vicinae = {
    enable = true;
    autoStart = true;
    settings = {
      faviconService = "twenty";
      font.size = 11;
      popToRootOnClose = false;
      rootSearch.searchFiles = false;
      theme.name = "vicinae-dark";
      window = {
        csd = true;
        opacity = 0.95;
        rounding = 10;
      };
    };

  };
}
