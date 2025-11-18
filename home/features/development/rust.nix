{
  pkgs,
  lib,
  ...
}: {
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

  home.activation.rustupInit = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.fish}/bin/fish ${./rust/init.fish}
  '';
}
