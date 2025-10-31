{pkgs, ...}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-material-color
      librime
      fcitx5-gtk
      kdePackages.fcitx5-qt
      qt6Packages.fcitx5-chinese-addons
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [jetbrains-mono];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["JetBrains Mono"];
        sansSerif = ["JetBrains Mono"]; # 可选：统一所有字体
        serif = ["JetBrains Mono"]; # 可选
      };
    };
  };

  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };
}
