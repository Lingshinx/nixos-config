{...}: let
  # 定义一个函数，接受四个参数，其中 is_opacity 默认 false
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
      ${fn_windows {
        app_name = "Telegram";
        app_id = "org.telegram.desktop";
        workspace_name = "5-fun";
      }}
      ${
        fn_windows {
          app_name = "netease-cloud-music-gtk4";
          app_id = "com.gitee.gmg137.NeteaseCloudMusicGtk4";
          workspace_name = "5-fun";
          extra_args = "opacity 0.75";
        }
      }
      ${fn_windows {
        app_name = "piliplus";
        app_id = "piliplus";
        workspace_name = "5-fun";
        extra_args = ''
          default-column-width {proportion 0.99;}
        '';
      }}
    '';
}
