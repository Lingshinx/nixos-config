{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest; # 使用最新内核
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

  services.displayManager.sddm.enable = true;
  services.xserver = {
    enable = true;
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  virtualisation.docker.enable = true;

  users.groups.davfs2 = { }; # 这一步是必须的
  users.users.yb = {
    isNormalUser = true; # 普通用户
    extraGroups = [
      "wheel"
      "uucp"
      "input"
      "docker"
      "davfs2"
    ]; # 可选：让 yb 有 sudo 权限
    group = "yb"; # 主组
  };

  users.groups.yb = { }; # 定义一个同名用户组
  services.blueman.enable = true; # 启用 Blueman
  hardware.bluetooth.enable = true; # 启用 BlueZ

  nixpkgs.config.allowUnfree = true;

  programs.niri.enable = true;
  programs.xwayland.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-gtk
      kdePackages.fcitx5-qt
      fcitx5-chinese-addons
    ];
  };

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    nixd
    zig
    gcc
    clang
    go
    google-chrome
    xray
    xremap
    gtk3
    gtk4
    xorg.xinit
    xwayland-satellite
    feishu
    v2rayn
    waybar
    vim
    alacritty
    yazi
    git
    chezmoi
    ghostty
    kitty
    neovim
    fuzzel
  ];

  environment.variables = {
    GOPROXY = "https://goproxy.cn,direct";
    HTTP_PROXY = "http://127.0.0.1:7897";
    HTTPS_PROXY = "http://127.0.0.1:7897";
  };

  nix = {
    package = pkgs.nix;

    settings = {
      sandbox = false;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [ "https://vicinae.cachix.org" ];
      extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];

    };

  };
  system.stateVersion = "25.11";
}
