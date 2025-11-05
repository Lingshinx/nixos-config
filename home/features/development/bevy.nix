{pkgs, ...}: {
  home.sessionVariables.PKG_CONFIG_PATH = "$PKG_CONFIG_PATH:${pkgs.alsa-lib.dev}/lib/pkgconfig:${pkgs.wayland.dev}/lib/pkgconfig:${pkgs.libxkbcommon.dev}/lib/pkgconfig:${pkgs.systemd.dev}/lib/pkgconfig";

  home.sessionVariables.LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.libxkbcommon}/lib:${pkgs.wayland}/lib:${pkgs.alsa-lib}/lib";

  home.packages = with pkgs; [
    pkg-config
    clang

    alsa-lib
    alsa-lib.dev

    wayland
    wayland.dev

    libxkbcommon
    libxkbcommon.dev

    udev
    # ⚠️ 不要加 systemd / systemd.dev 到这里
    vulkan-loader

    mesa
    vulkan-tools
    # Other dependencies
    libudev-zero

    xorg.libXi
    xorg.libX11
    xorg.libXext
    xorg.libXtst
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXrender
  ];
}
