{ pkgs, ... }:
{
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "thunar.desktop" ];
        "x-scheme-handler/file" = [ "thunar.desktop" ];
      };
    };
  };
  # 显式指定默认 backend，避免 1.17+ 的不确定性
  home.packages = with pkgs; [
    xfce.thunar
  ];

}
