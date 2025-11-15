# yb.nix
{
  pkgs,
  niri,
  currentHostName,
  my_hosts,
  ...
}: let
  is_pc1 = currentHostName == my_hosts.pc_1.hostName;
  is_co1 = currentHostName == my_hosts.Co_1.hostName;
in {
  home = {
    username = "yb";
    homeDirectory = "/home/yb";
    stateVersion = "25.11";
  };

  imports =
    [
      ./features/applications/kitty.nix
      ./features/applications/fcitx5.nix
      ./features/applications/fastfetch.nix

      ./features/development/git.nix
      ./features/development/taplo.nix
      ./features/development/nix_lsp.nix
      ./features/development/node.nix
      ./features/development/gitbutler.nix
      ./features/development/lua.nix
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
    ]
    ++ (
      if is_pc1
      then [
        ./features/desktop/google_nvidia.nix
        ./features/desktop/moonlight.nix
      ]
      else []
    );

  home.packages = with pkgs;
    [
      miniserve
      jj
      gitui
      autossh
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
      bottom
      jetbrains.rust-rover
      jetbrains.webstorm
      gnome-keyring
    ]
    ++ lib.optionals is_pc1 [
      telegram-desktop
      netease-cloud-music-gtk
      piliplus
    ]
    ++ lib.optionals is_co1 [
      jetbrains.pycharm-professional
      wpsoffice-cn
      vial
    ];
}
