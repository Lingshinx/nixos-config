{
  vicinae,
  ...
}:

{
  imports = [
    vicinae.homeManagerModules.default
  ];
  services.vicinae = {
    enable = true;
    autoStart = true;
    settings = {
      faviconService = "twenty";
      font.size = 11;
      popToRootOnClose = false;
      rootSearch.searchFiles = false;
      theme.name = "catppuccin-mocha";
      window = {
        csd = true;
        opacity = 0.90;
        rounding = 10;
      };
    };
  };
}
