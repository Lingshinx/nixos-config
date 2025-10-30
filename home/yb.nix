# yb.nix
{
  pkgs,
  niri,
  currentHostName,
  my_hosts,
  ...
}: {
  home = {
    username = "yb";
    homeDirectory = "/home/yb";
    stateVersion = "25.11";
  };

  imports = [
    ./features/applications/kitty.nix
    ./features/applications/fcitx5.nix

    ./features/development/git.nix
    ./features/development/nix_lsp.nix
    ./features/development/node.nix
    ./features/development/gitbutler.nix
    ./features/development/lua.nix
    ./features/development/nvim.nix
    ./features/development/rust.nix
    ./features/development/uv.nix
    ./features/development/ssh.nix
    ./features/development/my_idea.nix

    ./features/desktop/vicinae.nix
    ./features/desktop/gtk.nix
    ./features/desktop/qt.nix
    ./features/desktop/file_manager.nix

    niri.homeModules.niri
    ./features/desktop/dank-material-shell.nix
    ./features/desktop/niri/pc1.nix

    ./features/cli/atuin.nix
    ./features/cli/fish.nix
    ./features/cli/starship.nix
    ./features/cli/zoxide.nix
    ./features/cli/bat.nix
  ];

  home.packages = with pkgs;
    [
      miniserve
      somo
      p7zip
      dig
      flatpak
      docker-compose
      davfs2
      rclone
      libinput
      openssh
      hostname
      rustscan
      fastfetch
      bottom
      jetbrains.rust-rover
      jetbrains.webstorm
      gnome-keyring
    ]
    ++ lib.optionals (currentHostName == my_hosts.pc_1.hostName) [
      telegram-desktop
      netease-cloud-music-gtk
    ]
    ++ lib.optionals (currentHostName == my_hosts.Co_1.hostName) [
      jetbrains.pycharm-professional
    ];
}
