{ inputs, ... }:
{
  imports = [
    # 直接引用 flake 输入提供的模块
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.yb = import ./yb.nix;
    extraSpecialArgs = {
      inherit (inputs)
        niri
        vicinae
        dankMaterialShell
        quickshell
        ;
    };
  };
}
