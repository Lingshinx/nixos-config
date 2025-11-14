{pkgs, ...}: {
  home.packages = with pkgs; [
    sunshine
    moonlight
    moonlight-qt
    evtest
  ];
}
