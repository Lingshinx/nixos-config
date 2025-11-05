{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "google-chrome-stable-nvidia" ''
      exec env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia \
        ${pkgs.google-chrome}/bin/google-chrome-stable \
        --ozone-platform=x11 \
        --enable-features=Vulkan \
        --use-vulkan=native \
        --enable-webgpu \
        --enable-unsafe-webgpu "$@"
    '')
  ];

  xdg.desktopEntries.chrome-nvidia = {
    name = "Google Chrome (NVIDIA Vulkan)";
    exec = "google-chrome-stable-nvidia %U";
    icon = "google-chrome";
    categories = ["Network" "WebBrowser"];
    mimeType = ["text/html" "x-scheme-handler/http" "x-scheme-handler/https"];
  };
}
