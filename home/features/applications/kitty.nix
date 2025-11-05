{lib, ...}: let
  leader_key = "shift+space";
  leader = key: leader_key + ">" + key;
  mode = mode_name: key:
    lib.strings.join " " [
      "--mode"
      mode_name
      key
    ];
  resize = mode "resize";
  new_mode = mode_name: "--new-mode " + mode_name;
in {
  catppuccin.kitty.enable = true;

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono Nerd Font";
      size = 11;
    };
    settings = {
      cursor_shape = "beam";
      copy_on_select = "yes";
      cursor_trail = "1";
      window_margin_width = "1";
      confirm_os_window_close = "0";
      shell = "fish";
      scrollback_pager = "nvim -c 'set filetype=scrollback'";
    };

    extraConfig = ''
      # extra keybindings
      map ctrl+shift+f launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id

      map ${new_mode "resize"} ${leader "r"}
      map ${leader "s"} show_scrollback

      map ${resize "esc"} pop_keyboard_mode

      map ${resize "g>g"} scroll_home
      map ${resize "shift+g"} scroll_end
      map ${resize "home"} scroll_home
      map ${resize "end"} scroll_end
      map ${resize "k"} scroll_line_up
      map ${resize "j"} scroll_line_down
      map ${resize "space"} scroll_page_down
      map ${resize "shift+space"} scroll_page_up
      map ${resize "shift+bracketleft"} scroll_to_prompt -1
      map ${resize "shift+bracketright"} scroll_to_prompt 1
      map ${resize "plus"} change_font_size all +2.0
      map ${resize "minus"} change_font_size all -2.0
      map ${resize "equal"} change_font_size all 0
    '';
  };
}
