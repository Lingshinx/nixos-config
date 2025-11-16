{...}: let
  fn_windows = app_name: workspace_name: ''
    spawn-at-startup "${app_name}"
    window-rule {
        match app-id="${app_name}"
        open-on-workspace "${workspace_name}";
    }
  '';
in {
  xdg.configFile."niri/config.kdl".text =
    builtins.readFile ./config.kdl
    + ''
      ${fn_windows "dingtalk" "9-fun"}

    '';
}
