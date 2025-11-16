{pkgs, ...}: {
  home.packages = with pkgs; [
    nixfmt-rfc-style
    alejandra
    nixd
  ];
  programs.nix-index.enable = true;
}
