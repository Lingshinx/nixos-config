{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";

    fcitx5 = {
      accent = "green";
      flavor = "mocha";
      enable = true;
      enableRounded = true;
    };
  };
}
