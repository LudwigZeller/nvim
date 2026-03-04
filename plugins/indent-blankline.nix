{ ... }:
{
  plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "▎";
        tab_char = "";
      };
      scope = {
        show_end = true;
        show_exact_scope = true;
        show_start = true;
      };
      exclude.filetypes = [
        "dashboard"
        "help"
        "alpha"
        "neo-tree"
        "Trouble"
      ];
    };
  };
}
