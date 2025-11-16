{inputs, ...}: {
  nixpkgs = {
    overlays = [
      inputs.quickshell.overlays.default
      inputs.rust-overlay.overlays.default
      inputs.niri.overlays.niri
    ];
  };
}
