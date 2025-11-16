{inputs, ...}: let
  # 定义一个自定义 overlay
  v2rayNOverlay = self: super: {
    v2rayN = super.v2rayN.overrideAttrs (old: {
      postInstall =
        (old.postInstall or "")
        + ''
          mkdir -p $out/lib/v2rayn/bin
          ln -s ${super.sing-box}/bin/sing-box $out/lib/v2rayn/bin/sing_box
        '';
    });
  };
in {
  nixpkgs = {
    overlays = [
      inputs.quickshell.overlays.default
      inputs.rust-overlay.overlays.default
      inputs.niri.overlays.niri
      v2rayNOverlay
    ];
  };
}
