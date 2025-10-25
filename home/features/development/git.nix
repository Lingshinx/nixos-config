{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "yb";
    userEmail = "scauyb@qq.com";
    extraConfig = {
      gpg.format = "ssh";
      user.signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
      gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
      url."git@github.com:".insteadOf = "https://github.com/";
    };
  };
}