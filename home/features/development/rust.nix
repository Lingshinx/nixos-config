{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    rustup
    #    rust-bin.stable.latest.default
  ];

}
