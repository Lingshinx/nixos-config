{ ... }:

let
  leader_key = "alt+space";
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
      scrolllback_pager = "nvim -c 'set filetype=scrollback'"
    };

    keybindings = {
      "ctrl+f" =
        "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";

      leader "s" = "show_scrollback";
    };
  };
}
