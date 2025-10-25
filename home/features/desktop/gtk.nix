{ config, pkgs, ... }:

{
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
}