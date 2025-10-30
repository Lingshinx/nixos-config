# modules/common-modules.nix
{ inputs
, ...
}:

{
  imports = [
    inputs.chaotic.nixosModules.default

    inputs.nix-flatpak.nixosModules.nix-flatpak
    ./flatpak-declarative.nix

  ];

}
