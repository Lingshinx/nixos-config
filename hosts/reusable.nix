{ ... }:
{
  imports = [
    ./reusable/theme.nix
    ./reusable/development.nix
    ./reusable/overlays.nix
    ./reusable/input_method.nix
    ./reusable/file_manager.nix
    ./reusable/v1.nix
  ];
}
