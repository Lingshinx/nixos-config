{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.flatpak.enable = true;

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
  ];

  systemd.services."flatpak-managed-install".environment = {
    http_proxy = "http://127.0.0.1:7897";
    https_proxy = "http://127.0.0.1:7897";
    HTTP_PROXY = "http://127.0.0.1:7897";
    HTTPS_PROXY = "http://127.0.0.1:7897";
  };

  security.unprivilegedUsernsClone = true;
  systemd.services.flatpak.serviceConfig.RestrictNamespaces = false;

  environment.sessionVariables.XDG_DATA_DIRS = lib.mkAfter [
    "/var/lib/flatpak/exports/share"
    "/home/yb/.local/share/flatpak/exports/share"
  ];

  environment.sessionVariables.PATH = lib.mkBefore "/run/wrappers/bin";

  # Critical: provide setuid bubblewrap
  security.wrappers.bwrap = {
    source = "${pkgs.bubblewrap}/bin/bwrap";
    owner = "root";
    group = "root";
    permissions = "u+xs,g+rx,o+rx"; # 4755
  };
}
