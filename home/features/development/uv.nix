{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ uv ];

  home.activation.uv-python-313 = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if ! ${pkgs.uv}/bin/uv python which 3.13 >/dev/null 2>&1; then
      ${pkgs.uv}/bin/uv python install 3.13
    fi
  '';
}
