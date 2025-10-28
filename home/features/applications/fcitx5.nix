{ ... }:
{

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
  home.file.".local/share/fcitx5/rime/double_pinyin_flypy.custom.yaml".source =
    ./fcitx5/rime/double_pinyin_flypy.custom.yaml;

}
