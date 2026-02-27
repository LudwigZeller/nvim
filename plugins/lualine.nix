{ ... }:
{
  plugins.navic = {
    enable = true;
    settings = {
      lsp.autoAttach = true;
      highlight = true;
      separator = "  ";
      depth_limit = 5;
      lazy_update_context = true;
    };
  };

  plugins.lualine = {
    enable = true;
    settings = {
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          "filename"
          "diff"
        ];
        lualine_x = [
          "diagnostics"
          {
            __unkeyed-1.__raw = ''
              		    function()
                        local msg = ""
                        local buf_ft = vim.bo[0].filetype
                        local clients = vim.lsp.get_clients({ bufnr = 0 })
                        if next(clients) == nil then
                            return msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                            end
                        end
                        return msg
              		    end
              		  '';
            icon = "";
            color.fg = "#ffffff";
          }
          "encoding"
          "fileformat"
          "filetype"
        ];
        lualine_y = [
          {
            __unkeyed-1 = "aerial";
            cond.__raw = ''
              		    function()
              		      local buf_size_limit = 1024 * 1024
              		      if vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0)) > buf_size_limit then
                          return false
              		      end
              		      return true
              		    end
              		  '';
            sep = " ) ";
            depth.__raw = "nil";
            dense = false;
            dense_sep = ".";
            colored = true;
          }
        ];
        lualine_z = [ { __unkeyed-1 = "location"; } ];
      };

      winbar = {
        lualine_c = [ { __unkeyed-1 = "navic"; } ];
        lualine_x = [
          {
            __unkeyed-1 = "filename";
            newfile_status = true;
            path = 3;
            shorting_target = 150;
          }
        ];
      };

      inactive_winbar = {
        lualine_x = [
          {
            __unkeyed-1 = "filename";
            newfile_status = true;
            path = 3;
            shorting_target = 150;
          }
        ];
      };

      options = {
        icons_enabled = true;
        theme = "auto";
        component_separators = {
          left = "";
          right = "";
        };
        section_separators = {
          left = "";
          right = "";
        };
        always_divide_middle = true;
        globalstatus = false;
        refresh = {
          statusline = 1000;
          tabline = 1000;
          winbar = 1000;
        };
        disabled_filetypes = {
          statusline = [
            "help"
            "startify"
            "dashboard"
            "packer"
            "neogitstatus"
            "NvimTree"
            "neo-tree"
            "Trouble"
            "alpha"
            "lir"
            "Outline"
            "spectre_panel"
            "toggleterm"
            "qf"
            "OverseerList"
          ];
          winbar = [
            "help"
            "startify"
            "dashboard"
            "packer"
            "neogitstatus"
            "NvimTree"
            "neo-tree"
            "Trouble"
            "alpha"
            "lir"
            "Outline"
            "spectre_panel"
            "toggleterm"
            "qf"
            "OverseerList"
            "dapui_watches"
            "dapui_stacks"
            "dapui_breakpoints"
            "dapui_scopes"
            "dapui_console"
            "dap-repl"
          ];
        };
        ignore_focus = [
          "dapui_watches"
          "dapui_stacks"
          "dapui_breakpoints"
          "dapui_scopes"
          "dapui_console"
          "dap-repl"
          "aerial"
        ];
      };
    };
  };
}
