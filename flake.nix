{
  description = "My NixOS configuration";

  inputs = {

    nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?ref=master&rev=3e2ce40b18af943f9ba370ed73565e9f487663ef";
      #      inputs.nixpkgs.follows = "nixpkgs";
    };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-cli = {
      url = "github:AvengeMedia/danklinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
      inputs.dms-cli.follows = "dms-cli";
      inputs.quickshell.follows = "quickshell";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae"; # tell Nixos where to get Vicinae
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      vicinae,
      nixpkgs,
      chaotic,
      quickshell,
      home-manager,
      dankMaterialShell,
      niri,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib;
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./configuration.nix
          chaotic.nixosModules.default # IMPORTANT
          {
            environment.systemPackages = [
              quickshell.packages.${system}.default
            ];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            # 把第三方 flake 通过 extraSpecialArgs 传进 home.nix
            home-manager.extraSpecialArgs = {
              inherit
                dankMaterialShell
                niri
                ;
              vicinaeModule = vicinae.homeManagerModules.default;
            };
            home-manager.users.yb = import ./home.nix;

          }
        ];
      };

    };
}
