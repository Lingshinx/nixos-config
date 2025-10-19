# flake.nix
{
  description = "My NixOS configuration";

  inputs = {

    #    nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";
    #    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell"; # Use same quickshell version
    };

    quickshell = {
      #      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?ref=master&rev=3e2ce40b18af943f9ba370ed73565e9f487663ef";
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
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
      inputs.quickshell.follows = "quickshell"; # Use same quickshell version
      inputs.dgop.follows = "dgop";
      inputs.dms-cli.follows = "dms-cli";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae"; # tell Nixos where to get Vicinae
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
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
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            quickshell = quickshell.packages.${system}.quickshell;
          })
        ];
      };
      lib = pkgs.lib;
    in

    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs; }; # 显式传入
        modules = [
          ./configuration.nix
          #          ./noctalia.nix
          chaotic.nixosModules.default # IMPORTANT
          {
            environment.systemPackages = [
              pkgs.quickshell
            ];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit
                dankMaterialShell
                niri
                quickshell
                ;
              vicinaeModule = vicinae.homeManagerModules.default;
            };
            home-manager.users.yb = import ./home.nix;

          }
        ];
      };

    };
}
