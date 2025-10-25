{
  pkgs,
  lib,
  ...
}:

{
  # 1) 启用 Flatpak
  services.flatpak.enable = true;

  # 2) 允许非特权用户创建 user namespace（关键修复点）
  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  services.flatpak.packages = [
    {
      appId = "app.zen_browser.zen";
      origin = "flathub";
    }
    {
      appId = "com.dingtalk.DingTalk";
      origin = "flathub";
    }
  ];

  systemd.services."flatpak-managed-install".environment = {
    http_proxy = "http://127.0.0.1:7897";
    https_proxy = "http://127.0.0.1:7897";
    HTTP_PROXY = "http://127.0.0.1:7897";
    HTTPS_PROXY = "http://127.0.0.1:7897";
  };

  # 3) 可选：确保 XDG_DATA_DIRS 包含 Flatpak 导出路径（某些会话/显示管理器环境需要）
  security.unprivilegedUsernsClone = true;
  systemd.services.flatpak.serviceConfig.RestrictNamespaces = false;
  environment.sessionVariables.XDG_DATA_DIRS = lib.mkForce "/usr/share:/var/lib/flatpak/exports/share:/run/current-system/sw/share";

  environment.sessionVariables.PATH = lib.mkBefore "/run/wrappers/bin";

  # Critical: provide setuid bubblewrap
  security.wrappers.bwrap = {
    source = "${pkgs.bubblewrap}/bin/bwrap";
    owner = "root";
    group = "root";
    permissions = "u+xs,g+rx,o+rx"; # 4755
  };
}
