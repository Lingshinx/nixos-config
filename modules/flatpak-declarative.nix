{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Enable the base Flatpak service
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # Enable Flathub remote
  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  # Declarative install of Zen browser
  services.flatpak.packages = [
    {
      appId = "app.zen_browser.zen";
      origin = "flathub";
    }
  ];
}
