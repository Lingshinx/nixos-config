{inputs, ...}: {
  imports = [
    # 直接引用 flake 输入提供的模块
    inputs.home-manager.nixosModules.home-manager
  ];

  # Home‑Manager 在应用 dconfSettings 时需要 dconf 服务（ca.desrt.dconf），但你的系统里没有运行这个 DBus 服务。
  #home-manager-yb.service 因此在激活阶段失败，导致整个 Home‑Manager 环境没能启动。
  services.dbus.enable = true;
  programs.dconf.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.yb = {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
        inputs.nvim-config.homeModules.nvim-config
        inputs.niri.homeModules.niri
        inputs.nix-index-database.homeModules.nix-index
        ./yb.nix
      ];
    };
    extraSpecialArgs = {
      inherit
        (inputs)
        niri
        vicinae
        dankMaterialShell
        quickshell
        ;
    };
  };
}
