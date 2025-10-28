{ ... }:

let
  y_func = builtins.readFile ./fish/functions/y.fish;
in
{
  programs.fish = {
    enable = true;

    functions = {
      y = y_func;
    };

    # 仍可混合使用 declarative 初始化
    interactiveShellInit = ''
      fish_vi_key_bindings

        # fish 4.0 之后不要再用 -k
        bind \cr 'commandline -f execute'   # Ctrl-r
        bind \cc kill-whole-line repaint    # Ctrl-c
        bind \cd forward-char               # Ctrl-d
    '';
  };

}
