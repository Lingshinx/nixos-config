{
  pkgs,
  lib,
  ...
}: let
  rustupConfig = pkgs.writeText "cargo-config.toml" ''
    [target.x86_64-unknown-linux-gnu]
    linker = "${pkgs.clang}/bin/clang"
  '';
in {
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
    mkdir -p $HOME/.cargo
    cp ${rustupConfig} $HOME/.cargo/config.toml
    ${pkgs.rustup}/bin/rustup install stable
    ${pkgs.rustup}/bin/rustup component add rustfmt clippy rust-analyzer
  '';
}
