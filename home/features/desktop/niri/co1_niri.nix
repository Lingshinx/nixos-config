{...}: let
  fn_windows = {
    app_name,
    app_id,
    workspace_name,
    extra_args ? "",
  }: ''
    window-rule {
      match app-id="${app_id}"
      open-on-workspace "${workspace_name}"
      ${extra_args}
    }
    spawn-at-startup "${app_name}"
  '';
in {
  xdg.configFile."niri/config.kdl".text =
    builtins.readFile ./config.kdl
    + ''
      ${
        fn_windows {
          app_name = "google-chrome-stable";
          app_id = "google-chrome";
          workspace_name = "2-browser";
        }
      }
          window-rule {
            match app-id="com.alibabainc.dingtalk"
            open-on-workspace "9-fun"
          }
          spawn-sh-at-startup "sleep 5 && com.dingtalk.DingTalk"

    '';
}
