{...}: let
  # theme = "sakuraPink";
  theme = "teal";
  Theme2 = "Material-Color-${theme}";
in {
  catppuccin.fcitx5 = {
    accent = "green";
    flavor = "mocha";
    enable = true;
    apply = true;
    enableRounded = true;
  };

  #  home.file = {
  #    ".local/share/fcitx5/themes".source = "${pkgs.fcitx5-material-color}/share/fcitx5/themes";
  #  };

  #  # 设置 classicui 使用 pink 主题
  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    Theme=${Theme2}
    Font="JetBrains Mono 11"
    PerScreenDPI=True
    Vertical Candidate List=True
  '';

  xdg.configFile."fcitx5/profile".text = ''
    [Groups/0]
    Name=Default
    Default Layout=us
    DefaultIM=rime

    [Groups/0/Items/0]
    Name=keyboard-us
    Layout=

    [Groups/0/Items/1]
    Name=rime
    Layout=

    [GroupOrder]
    0=Default
  '';

  home.file.".local/share/fcitx5/rime/default.custom.yaml".source = ./fcitx5/rime/default.custom.yaml;

  home.file.".local/share/fcitx5/rime/default.yaml".source = ./fcitx5/rime/default.yaml;
  home.file.".local/share/fcitx5/rime/double_pinyin_flypy.schema.yaml".source =
    ./fcitx5/rime/double_pinyin_flypy.schema.yaml;
}
