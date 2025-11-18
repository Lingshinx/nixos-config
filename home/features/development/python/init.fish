#!/usr/bin/env fish

set uv "${pkgs.uv}/bin/uv"

if test (count ($uv python list | string match -r '3\.13')) -eq 0
  echo "Installing Python 3.13 via uv..."
  $uv python install 3.13
else
  echo "Python 3.13 already installed."
end
