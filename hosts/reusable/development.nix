{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # 基础工具
    pkg-config
    clang

    # 音频
    alsa-lib
    alsa-lib.dev

    # Vulkan
    vulkan-loader
    vulkan-tools

    # X11 / Wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    xorg.libXext
    xorg.libXtst
    xorg.libXrender
    wayland
    wayland.dev
    libxkbcommon
    libxkbcommon.dev

    # 其他依赖
    openssl
    openssl.dev
    libudev-zero
    udev
    fontconfig
    freetype
    glib
    mesa
  ];

  environment.variables = {
    PKG_CONFIG_PATH = lib.concatStringsSep ":" [
      "${pkgs.alsa-lib.dev}/lib/pkgconfig"
      "${pkgs.wayland.dev}/lib/pkgconfig"
      "${pkgs.libxkbcommon.dev}/lib/pkgconfig"
      "${pkgs.systemd.dev}/lib/pkgconfig"
      "${pkgs.openssl.dev}/lib/pkgconfig"
      "${pkgs.udev.dev}/lib/pkgconfig"
    ];
    LD_LIBRARY_PATH = lib.makeLibraryPath [
      pkgs.vulkan-loader
      pkgs.xorg.libX11
      pkgs.xorg.libXi
      pkgs.xorg.libXcursor
      pkgs.libxkbcommon
      pkgs.wayland
      pkgs.alsa-lib
      pkgs.openssl
      pkgs.udev
      pkgs.libudev-zero
    ];
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      vulkan-loader
      libxkbcommon
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXtst
      xorg.libXi
      xorg.libXcursor
      xorg.libXrandr
      fontconfig
      freetype
      glib
      wayland
      alsa-lib
      openssl
      libudev-zero
      udev
      mesa
    ];
  };
}
