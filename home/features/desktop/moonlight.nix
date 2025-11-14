{pkgs, ...}: {
  home.packages = with pkgs; [
    moonlight
    moonlight-qt
    evtest
  ];
}
