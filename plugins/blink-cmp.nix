{ pkgs, ... }:
{
  extraPlugins = with pkgs; [
    vimPlugins.friendly-snippets
  ];

  plugins = {
    blink-emoji.enable = true;
  };

  plugins.blink-cmp = {
    enable = true;
    settings = {
      snippets.preset = "default";
      sources = {
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
          "emoji"
        ];
        providers = {
          emoji = {
            name = "Emoji";
            module = "blink-emoji";
          };
        };
      };
      keymap = {
        preset = "default";

        "<CR>" = [
          "accept"
          "fallback"
        ];

        "<Tab>" = [
          "select_next"
          "snippet_forward"
          "fallback"
        ];

        "<S-Tab>" = [
          "select_prev"
          "snippet_backward"
          "fallback"
        ];

        "<Up>" = [
          "select_prev"
          "fallback"
        ];
        "<Down>" = [
          "select_next"
          "fallback"
        ];

        "<C-b>" = [
          "scroll_documentation_up"
          "fallback"
        ];
        "<C-f>" = [
          "scroll_documentation_down"
          "fallback"
        ];

        "<C-space>" = [
          "show"
          "show_documentation"
          "hide_documentation"
        ];
        "<C-e>" = [
          "hide"
          "fallback"
        ];
      };
      completion = {
        ghost_text.enabled = true;
        menu.draw = {
          columns = [
            [ "kind_icon" ]
            [
              "label"
              "label_description"
            ]
            [ "source_name" ]
          ];
        };
      };
    };
  };

}
