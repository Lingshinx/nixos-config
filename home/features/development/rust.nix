{pkgs, ...}: {
  home.packages = with pkgs; [
    #    (pkgs.rust-bin.stable.latest.default.override {
    #      extensions = [
    #        "rustfmt"
    #        "clippy"
    #        "rust-src"
    #        "llvm-tools-preview"
    #      ];
    #    })
    #
    rustup
  ];
}
