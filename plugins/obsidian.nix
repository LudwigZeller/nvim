{ pkgs, ... }: {

  plugins.render-markdown = {
    enable = true;
    settings = {
      render_modes = true;
      completions = {
        lsp = {
          enabled = true;
        };
      };
      quote = {
        repeat_linebreak = true;
      };
      latex = {
        enabled = false;
        render_modes = true;
        converter = [
          "utftex"
          "latex2text"
        ];
        inline = true;
        block = true; # Render Latex should do that
        highlight = "RenderMarkdownMath";
        position = "center";
        top_pad = 0;
        bottom_pad = 0;
      };
      callout = {
        note = {
          raw = "[!NOTE]";
          rendered = "󰋽 Note";
          highlight = "RenderMarkdownInfo";
          category = "github";
        };

        tip = {
          raw = "[!TIP]";
          rendered = "󰌶 Tip";
          highlight = "RenderMarkdownSuccess";
          category = "github";
        };

        important = {
          raw = "[!IMPORTANT]";
          rendered = "󰅾 Important";
          highlight = "RenderMarkdownHint";
          category = "github";
        };

        warning = {
          raw = "[!WARNING]";
          rendered = "󰀪 Warning";
          highlight = "RenderMarkdownWarn";
          category = "github";
        };

        caution = {
          raw = "[!CAUTION]";
          rendered = "󰳦 Caution";
          highlight = "RenderMarkdownError";
          category = "github";
        };

        notation = {
          raw = "[!notation]";
          rendered = " Notation";
          highlight = "RenderMardownHint";
          category = "math";
        };

        proposition = {
          raw = "[!proposition]";
          rendered = " Proposition";
          highlight = "RenderMarkdownInfo";
          category = "math";
        };

        lemma = {
          raw = "[!lemma]";
          rendered = " Lemma";
          highlight = "RenderMarkdownSuccess";
          category = "math";
        };

        corollary = {
          raw = "[!corollary]";
          rendered = " Corollary";
          highlight = "RenderMarkdownInfo";
          category = "math";
        };

        theorem = {
          raw = "[!theorem]";
          rendered = " theorem";
          highlight = "RenderMarkdownSuccess";
          category = "math";
        };

        definiton = {
          raw = "[!definiton]";
          rendered = " Definiton";
          highlight = "RenderMarkdownInfo";
          category = "math";
        };
      };
    };

  };

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "math-conceal.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "pxwg";
        repo = "math-conceal.nvim";
        tag = "0.2.4";
        sha256 = "sha256-T+N7GX2PMpjT52lNXEdBvONX8ie7WlEx+5v4U3YxYlY=";
      };
    })
  ];
  extraPackages = [
    (pkgs.rustPlatform.buildRustPackage rec {
      pname = "typst-concealer-service";
      version = "0.2.4";
      src =
        (pkgs.fetchFromGitHub {
          owner = "pxwg";
          repo = "math-conceal.nvim";
          tag = "0.2.4";
          sha256 = "sha256-T+N7GX2PMpjT52lNXEdBvONX8ie7WlEx+5v4U3YxYlY=";
        })
        + "/service";
      cargoLock.lockFile = "${src}/Cargo.lock";

      nativeBuildInputs = with pkgs; [ pkg-config ];
      buildInputs = with pkgs; [
        openssl
      ];
    })
  ];

  extraConfigLua = /* lua */ ''
    require("math-conceil.nvim").setup({
    	conceal = {
    		"greek",
    		"script",
    		"math",
    		"font",
    		"delim",
    		"phy",
    	},
    	ft = { "plaintex", "tex", "context", "bibtex", "markdown", "typst" },
    	opt = {
    		conceallevel = 2,
    		concealcursor = "n",
    	},
    	image = {
    		enabled = true, -- set true to enable graphical equation conceal
    		markdown = {
    			filetypes = { "markdown" },
    			service_binary = "typst-concealer-service",
    		},
    	},
    })
  '';

  plugins.obsidian = {
    # enable = true;
  };
}
