# flake.nix
{
  description = "My NixOS configuration";

  inputs = {

    nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";

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

    quickshell = {
      url = "github:quickshell-mirror/quickshell"; # no ?rev=<hash>
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
      quickshell,
      dankMaterialShell,
      niri,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ quickshell.overlays.default ];
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

      nixosConfigurations = {
        pc_1 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/pc_1/configuration.nix
            ./modules/nvidia.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.yb = import ./home.nix;
            }
          ]
          ++ commonModules;

        };

        Co_1 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/Co_1/configuration.nix
          ]
          ++ commonModules;

        };
      };

    };
}
