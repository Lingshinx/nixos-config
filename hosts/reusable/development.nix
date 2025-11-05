{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
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
    ];
  };
}
