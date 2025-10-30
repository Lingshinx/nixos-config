{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    lazygit
  ];
  programs.git = {
    enable = true;
    settings = {
      user.name = "yb";
      user.email = "scauyb@qq.com";

      gpg.format = "ssh";
      user.signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
      gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";

      url."git@github.com:".insteadOf = "https://github.com/";
    };
  };
}
