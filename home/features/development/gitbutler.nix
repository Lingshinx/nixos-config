{ pkgs, ... }:
{
  # maybe it's a good way to manage my git repos
  home.packages = with pkgs; [
    # now don't use it , version is too old in nixos, and can't use it by other way
    #    mesa
    #    libglvnd
    #    xorg.libX11
    #    xorg.libXext
    #    xorg.libXrender
    appimage-run
    gitbutler
  ];
}
