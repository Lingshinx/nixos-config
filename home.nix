# home.nix
{
  config,
  pkgs,
  lib,
  vicinaeModule,
  dankMaterialShell,
  niri,
  quickshell,
  ...
}:

{
  home.username = "yb";
  home.homeDirectory = "/home/yb";
  home.stateVersion = "25.11";

  imports = [
    dankMaterialShell.homeModules.dankMaterialShell.default
    dankMaterialShell.homeModules.dankMaterialShell.niri
    niri.homeModules.niri
    vicinaeModule
  ];
  # 启用 ssh-agent（便于签名与认证）
  programs = {
    ssh = {
      enable = true;
      # 关键：关闭未来将废弃的默认配置
      enableDefaultConfig = false;
      # 如果你需要保留一些默认值，可以自己写在这里
      matchBlocks."*" = {
        forwardAgent = true;
        serverAliveInterval = 60;
      };
    };
    git = {
      enable = true;
      userName = "yb";
      userEmail = "scauyb@qq.com";
      extraConfig = {
        gpg.format = "ssh";
        user.signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        commit.gpgsign = true;
        gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
        url."git@github.com:".insteadOf = "https://github.com/";
      };
    };
    kitty = {
      enable = true;
      font = {
        name = "JetBrains Mono Nerd Font";
        size = 11;
      };
      settings = {
        cursor_shape = "beam";
        copy_on_select = "yes";
        cursor_trail = "1";
        window_margin_width = "1";
        confirm_os_window_close = "0";
        shell = "fish";
      };

      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+f" =
          "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
        "kitty_mod+f" =
          "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
        "page_up" = "scroll_page_up";
        "page_down" = "scroll_page_down";
        "ctrl+plus" = "change_font_size all +1";
        "ctrl+equal" = "change_font_size all +1";
        "ctrl+kp_add" = "change_font_size all +1";
        "ctrl+minus" = "change_font_size all -1";
        "ctrl+underscore" = "change_font_size all -1";
        "ctrl+kp_subtract" = "change_font_size all -1";
        "ctrl+0" = "change_font_size all 0";
        "ctrl+kp_0" = "change_font_size all 0";
      };

      # 对于 include 或模块没覆盖的配置，用 extraConfig
      #      extraConfig = ''
      #        include hyde.conf
      #      '';

    };
  };
  services = {
    ssh-agent.enable = true;
    vicinae = {
      enable = true;
      autoStart = true;
      settings = {
        faviconService = "twenty";
        font.size = 11;
        popToRootOnClose = false;
        rootSearch.searchFiles = false;
        theme.name = "vicinae-dark";
        window = {
          csd = true;
          opacity = 0.95;
          rounding = 10;
        };
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
    };
  };
  # 关键：强制覆盖 GTK 配置文件
  xdg = {
    configFile."gtk-3.0/settings.ini".force = true;
    configFile."gtk-4.0/settings.ini".force = true;
    configFile."gtk-4.0/gtk.css" = {
      text = ''
        @import url("dank-colors.css");
        @import url("${pkgs.gnome-themes-extra}/share/themes/Adwaita-dark/gtk-4.0/gtk.css");
      ''; # 空内容或你的样式
      force = true;
    };
  };

  programs.dankMaterialShell = {
    enable = true;
    quickshell.package = quickshell.packages.${pkgs.system}.default;

  };
  home.activation.postActivation = ''
    if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
      echo "Generating SSH key for user $USER..."
      mkdir -p "$HOME/.ssh"
      chmod 700 "$HOME/.ssh"
      ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" -C "$USER@$( ${pkgs.hostname}/bin/hostname )"
    fi
  '';
  home.packages = with pkgs; [
    miniserve
    dig
    flatpak
    docker-compose
    davfs2
    rclone
    tailscale
    fcitx5-configtool
    libinput
    openssh
    hostname
    rustscan
    fastfetch
    bottom
    qq
    atuin
    starship
    zoxide
    bat
    jetbrains.rust-rover
    jetbrains.webstorm
    telegram-desktop_git
    netease-cloud-music-gtk
    gnome-keyring
    vscode
    nixfmt-rfc-style
  ];
}
