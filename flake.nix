# flake.nix
{
  description = "My NixOS configuration version 0.7 ";
  outputs = inputs: let
    lib = inputs.nixpkgs.lib;
    my_hosts = import ./modules/my_hosts.nix;

    hosts = {
      pc_1 = [
        ./hosts/pc_1/configuration.nix
        ./modules/nvidia.nix
        ./home/manager.nix
      ];
      Co_1 = [
        ./hosts/Co_1/configuration.nix
        ./modules/host_1.nix
        ./home/manager.nix
        ./modules/gpu_intel.nix
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
    # nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz"; #this will make version dirty
    # nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # it's my config
    nvim-config = {
      url = "github:yebei199/nvim-config?ref=master";
      #      url = "github:Lingshinx/nvim-config?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
    flake-utils.url = "github:numtide/flake-utils";

    #    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
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
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };

    vicinae = {
      # lock the version until  a stable release
      url = "github:vicinaehq/vicinae?rev=a7b0455ac41098c4437deb472eedd4fcb8158ff0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
