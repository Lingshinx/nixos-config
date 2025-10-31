# flake.nix
{
  description = "My NixOS configuration version 0.4 ";
  outputs = inputs: let
    lib = inputs.nixpkgs.lib;
    my_hosts = import ./modules/my_hosts.nix;

    hosts = {
      pc_1 = [
        ./hosts/pc_1/configuration.nix
        ./modules/nvidia.nix
        ./modules/host_1.nix
        ./home.nix
      ];
      Co_1 = [
        ./hosts/Co_1/configuration.nix
        ./modules/host_1.nix
        ./home.nix
      ];
    };

    mkHost = name: modules:
      lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs my_hosts;};
        modules =
          modules
          ++ [
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                # ✅ name 是 mkHost 的参数，已定义
                currentHostName = my_hosts.${name}.hostName;
                inherit my_hosts;
              };
            }
          ];
      };
  in {
    nixosConfigurations = lib.mapAttrs mkHost hosts;
  };
  inputs = {
    # add kk can use mirrors
    nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
    #nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
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
      inputs.dgop.follows = "dgop";
      inputs.dms-cli.follows = "dms-cli";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
