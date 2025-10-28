{ ... }:
{
  xdg.configFile."niri/config.kdl".text = builtins.readFile ./config.kdl + ''
    // extra lines hh
  '';
}
