{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    ripgrep
    neovide
  ];

  xdg.configFile."nvim" = {
    source = ./nvim/ling_shin;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

}
