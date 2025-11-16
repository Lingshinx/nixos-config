{pkgs, ...}: {
  home.packages = with pkgs; [
    mpv
    mpvScripts.uosc
    qbittorrent
  ];
}
