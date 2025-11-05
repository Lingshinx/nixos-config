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
    packages = with pkgs; [
      jetbrains-mono
      noto-fonts-cjk-sans # ← 正确包名，支持简体/繁体/日韩
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["JetBrains Mono"];
        sansSerif = ["Noto Sans CJK SC"]; # SC = Simplified Chinese
        serif = ["Noto Serif CJK SC"];
      };
    };
  };

  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };
}
