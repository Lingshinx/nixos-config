{pkgs, ...}: let
  nixosLogo = pkgs.fetchurl {
    url = "https://icon.icepanel.io/Technology/svg/NixOS.svg";
    sha256 = "sha256-vWpdwSEdM1aWS3mg+jGNInU1dqL2SjCZMO4folkGfN4=";
  };

  nixosLogoPng = pkgs.runCommand "nixos-logo.png" {buildInputs = [pkgs.librsvg];} ''
    rsvg-convert -w 256 -h 256 -o $out ${nixosLogo}
  '';
in {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty";
        source = "${nixosLogoPng}";
        padding = {
          left = 2;
          right = 4;
        };
      };

      display = {
        separator = "  ";
      };

      modules = [
        {
          type = "custom";
          key = "── System ──";
        }
        {type = "os";}
        {type = "kernel";}
        {type = "uptime";}
        {type = "packages";}
        {type = "break";}

        {
          type = "custom";
          key = "── Environment ──";
        }
        {type = "shell";}
        {type = "terminal";}
        {type = "wm";}
        {type = "de";}
        {type = "theme";}
        {type = "icons";}
        {type = "font";}
        {type = "break";}

        {
          type = "custom";
          key = "── Hardware ──";
        }
        {type = "cpu";}
        {type = "gpu";}
        {type = "memory";}
        {type = "swap";}
        {type = "disk";}
        {type = "temperature";}
        {type = "display";}
        {type = "break";}

        {
          type = "custom";
          key = "── Network ──";
        }
        {type = "localip";}
        {type = "publicip";}
        {type = "break";}

        {
          type = "custom";
          key = "── Time ──";
        }
        {type = "datetime";}
      ];
    };
  };
}
