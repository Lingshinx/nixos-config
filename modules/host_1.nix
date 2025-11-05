# modules/common-modules.nix
{inputs, ...}: {
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
    ./flatpak-declarative.nix
  ];
}
