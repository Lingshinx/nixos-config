# flake.nix
{
  description = "My NixOS configuration";

  inputs = {

    nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";
    #    nixpkgs.url = "github:NixOS/nixpkgs";
    #    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #    stable.url = "github:nixos/nixpkgs/nixos-25.05";
    #    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #    quickshell = {
    #      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?ref=master&rev=f12f0e7c7d883f737ac45b88c5993090b3c87cce";
    #      #      url = "github:outfoxxed/quickshell";
    #      inputs.nixpkgs.follows = "nixpkgs";
    #    };

    quickshell = {
      #      url = "git+https://git.outfoxxed.me/quickshell/quickshell?ref=master";
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?ref=master&rev=f12f0e7c7d883f737ac45b88c5993090b3c87cce";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
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
      inputs.quickshell.follows = "quickshell";
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
      nix-flatpak,
      home-manager,
      dankMaterialShell,
      niri,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        #        overlays = [
        #          (final: prev: {
        #            quickshell = prev.quickshell.overrideAttrs (old: {
        #              version = "unstable-${quickshell.rev}";
        #              src = quickshell;
        #            });
        #          })
        #        ];
      };
      lib = pkgs.lib;
      commonModules = import ./modules/host_1.nix {
        inherit
          pkgs
          inputs
          home-manager
          chaotic
          nix-flatpak
          vicinae
          ;
        dankMaterialShell = inputs.dankMaterialShell;
        niri = inputs.niri;
      };
    in

    {
      #      packages.${system}.quickshell = pkgs.quickshell;

      nixosConfigurations = {
        pc_1 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/pc_1/configuration.nix
            commonModules
            ./modules/nvidia.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.yb = import ./home.nix;
            }
          ];

        };

        Co_1 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/Co_1/configuration.nix
            commonModules
          ];
        };
      };

    };
}
