{ lib, ... }:

let
  leader_key = "alt+space";
  leader = key: leader_key + ">" + key;
  mode = mode_name: key: lib.strings.join " " ["--mode" , mode_name , key];
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
      scrollback_pager = "nvim -c 'set filetype=scrollback'"
    };

    keybindings = {
      "ctrl+f" =
        "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";

      ${leader "s"} = "show_scrollback";

      ${new_mode "resize"} = leader "r";
      ${resize "esc"} = "pop_keyboard_mode";

      ${resize "g>g"} = "scroll_home";
      ${resize "shift+g"} = "scroll_end";
      ${resize "home"} = "scroll_home";
      ${resize "end"} = "scroll_end";
      ${resize "k"} = "scroll_line_up";
      ${resize "j"} = "scroll_line_down";
      ${resize "space"} = "scroll_page_down";
      ${resize "shift+space"} = "scroll_page_up";
      ${resize "shift+bracketleft"} = "scroll_to_prompt -1";
      ${resize "shift+bracketright"} = "scroll_to_prompt 1";
      ${resize "plus"} =  "change_font_size all +2.0";
      ${resize "minus"} = "change_font_size all -2.0";
      ${resize "equal"} = "change_font_size all 0";
    };
  };
}
