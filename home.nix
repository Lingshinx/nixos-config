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

  # 引入 DankMaterialShell 和 Niri 的 Home Manager 模块
  imports = [
    dankMaterialShell.homeModules.dankMaterialShell.default
    dankMaterialShell.homeModules.dankMaterialShell.niri
    niri.homeModules.niri
    vicinaeModule
  ];

  home.activation.postActivation = ''
    if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
      echo "Generating SSH key for user $USER..."
      mkdir -p "$HOME/.ssh"
      chmod 700 "$HOME/.ssh"
      ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" -C "$USER@$( ${pkgs.hostname}/bin/hostname )"
    fi
  '';

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

  #programs.niri.enable = true;
  # 启用 DankMaterialShell
  programs.dankMaterialShell.enable = true;

  # 其他常用包
  home.packages = with pkgs; [
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
}
