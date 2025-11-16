{
  config,
  pkgs,
  ...
}: let
  name = "Sibyl";
  email = "scauyb@qq.com";
in {
  home.packages = with pkgs; [
    lazygit
    gh

    jujutsu
    jjui
    meld
    delta
  ];
  programs = {
    git = {
      enable = true;
      settings = {
        user.name = name;
        user.email = email;

        gpg.format = "ssh";
        user.signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        commit.gpgsign = true;
        gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";

        url."git@github.com:".insteadOf = "https://github.com/";
      };
    };

    jujutsu = {
      enable = true;
      settings = {
        user.name = name;
        user.email = email;
        ui.editor = "nvim";
        ui.diff-editor = "meld";
        merge.tool = "meld";
        diff.tool = "delta";
        ui.default-command = "log";

        git.remote = "origin";
        git.auto-local-branch = true;
        git.fetch = true;
        git.push-branch-prefix = "";
      };
    };
  };
}
