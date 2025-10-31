{ pkgs, ... }:
{
  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.wayland.dev}/lib/pkgconfig:$PKG_CONFIG_PATH";
  };

  home.packages = with pkgs; [
    pkg-config
    wayland.dev
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    alsa-lib
    udev
    vulkan-loader
  ];
}
