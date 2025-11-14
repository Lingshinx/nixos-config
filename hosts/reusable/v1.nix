{pkgs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest; # 使用最新内核
  };

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  zramSwap.enable = true;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32768;
    }
  ];

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    blueman.enable = true; # 启用 Blueman
  };
  hardware.bluetooth.enable = true; # 启用 BlueZ

  programs = {
    niri.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
    fish.enable = true;
  };

  users.defaultUserShell = pkgs.fish;
  virtualisation.docker.enable = true;

  users = {
    groups = {
      yb = {}; # 定义一个同名用户组
      davfs2 = {}; # 这一步是必须的
      plugdev = {};
    };

    users.yb = {
      isNormalUser = true; # 普通用户
      extraGroups = [
        "wheel"
        "uucp"
        "input"
        "dialout"
        "plugdev"
        "docker"
        "davfs2"
      ];
      group = "yb"; # 主组
    };
  };
  services.udev.extraRules = ''
    # Vial/VIA 规则
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0664", GROUP="plugdev", TAG+="uaccess"
  '';

  environment.systemPackages = with pkgs; [
    pciutils
    mesa-demos
    zig
    gcc
    cmake
    clang
    go
    google-chrome
    xray
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
    kitty
    fuzzel
  ];

  environment.variables = {
    GOPROXY = "https://goproxy.cn,https://proxy.golang.org,direct";
    HTTP_PROXY = "http://127.0.0.1:7897";
    HTTPS_PROXY = "http://127.0.0.1:7897";
  };

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      sandbox = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = ["https://vicinae.cachix.org"];
      extra-trusted-public-keys = ["vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="];
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
        #        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
    };
  };
  system.stateVersion = "25.11";
}
