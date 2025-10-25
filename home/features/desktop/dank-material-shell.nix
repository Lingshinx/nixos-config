{
  pkgs,
  quickshell,
  dankMaterialShell,
  ...
}:

{
  imports = [
    dankMaterialShell.homeModules.dankMaterialShell.default
    dankMaterialShell.homeModules.dankMaterialShell.niri

  ];
  programs.dankMaterialShell = {
    enable = true;
    quickshell.package = quickshell.packages.${pkgs.system}.default;
  };
}
