{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    uv
    ruff
    pyrefly
    pyright
  ];

  home.activation.python_init = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.fish}/bin/fish ${./python/init.fish}
  '';
}
