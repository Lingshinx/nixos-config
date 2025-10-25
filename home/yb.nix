# yb.nix
{
  pkgs,
  niri,
  vicinaeModule,
  dankMaterialShell,
  ...
}:

{
  home.username = "yb";
  home.homeDirectory = "/home/yb";
  home.stateVersion = "25.11";

  imports = [
    ./features/applications/kitty.nix

    ./features/development/git.nix
    ./features/development/ssh.nix

    ./features/desktop/vicinae.nix
    ./features/desktop/gtk.nix
    ./features/desktop/qt.nix
    ./features/desktop/dank-material-shell.nix

    ./features/cli/atuin.nix
    ./features/cli/starship.nix
    ./features/cli/zoxide.nix
    ./features/cli/bat.nix
    niri.homeModules.niri
  ];

  home.activation.postActivation = ''
    if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
      echo "Generating SSH key for user $USER..."
      mkdir -p "$HOME/.ssh"
      chmod 700 "$HOME/.ssh"
      ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" -C "$USER@$( ${pkgs.hostname}/bin/hostname )"
    fi
  '';

  home.packages = with pkgs; [
    miniserve
    dig
    flatpak
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
}
