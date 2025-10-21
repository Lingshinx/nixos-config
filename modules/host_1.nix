# modules/common-modules.nix
{
  pkgs,
  inputs,
  home-manager,
  chaotic,
  nix-flatpak,
  vicinae,
  dankMaterialShell,
  niri,
  ...
}:
[
  chaotic.nixosModules.default
  ./noctalia.nix

  nix-flatpak.nixosModules.nix-flatpak
  ./flatpak-declarative.nix

  {
    environment.systemPackages = [
      inputs.quickshell.packages.${pkgs.system}.default
    ];
  }

  home-manager.nixosModules.home-manager
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "backup";
    home-manager.extraSpecialArgs = {
      inherit dankMaterialShell niri;
      vicinaeModule = vicinae.homeManagerModules.default;
    };
  }
]
