{ ... }:
{
  autoCmd = [
    {
      event = "BufDelete";
      callback.__raw = ''
        function()
          vim.schedule(function()
            local buffers = vim.fn.getbufinfo({ buflisted = 1 })
            if #buffers == 1 then
              local buf = buffers[1]
              if buf.name == "" and vim.bo[buf.bufnr].filetype == "" and not vim.bo[buf.bufnr].modified then
                pcall(function() require("alpha").start(true) end)
                pcall(function() vim.api.nvim_buf_delete(buf.bufnr, { force = true }) end)
              end
            end
          end)
        end
      '';
      desc = "Open Dashboard when no buffers remain";
    }
  ];

  plugins = {
    bufdelete.enable = true;
    web-devicons.enable = true;
  };

  plugins.bufferline = {
    enable = true;
    settings.options = {
      custom_filter = ''
        function(buf_number)
          local name = vim.api.nvim_buf_get_name(buf_number)
          local ft = vim.bo[buf_number].filetype
          -- Hide if unnamed, no filetype, and unmodified
          if name == "" and ft == "" and not vim.bo[buf_number].modified then
            return false
          end
          return true
        end
      '';
      show_buffer_close_icons = false;
    };
  };

  keymaps = [
    # Fast Navigation
    {
      action = "<cmd>BufferLineCyclePrev<cr>";
      key = "<S-h>";
      mode = [ "n" ];
      options = {
        desc = "Previous buffer";
      };
    }
    {
      action = "<cmd>BufferLineCycleNext<cr>";
      key = "<S-l>";
      mode = [ "n" ];
      options = {
        desc = "Next buffer";
      };
    }

    # Reordering Buffers
    {
      action = "<cmd>BufferLineMovePrev<cr>";
      key = "<C-S-h>";
      mode = [ "n" ];
      options = {
        desc = "Move buffer left";
      };
    }
    {
      action = "<cmd>BufferLineMoveNext<cr>";
      key = "<C-S-l>";
      mode = [ "n" ];
      options = {
        desc = "Move buffer right";
      };
    }

    # Bracket Navigation
    {
      action = "<cmd>BufferLineCyclePrev<cr>";
      key = "[b";
      mode = [ "n" ];
      options = {
        desc = "Prev buffer";
      };
    }
    {
      action = "<cmd>BufferLineCycleNext<cr>";
      key = "]b";
      mode = [ "n" ];
      options = {
        desc = "Next buffer";
      };
    }

    # Leader Mappings
    {
      action = "<cmd>enew<cr>";
      key = "<leader>bn";
      mode = [ "n" ];
      options = {
        desc = "New buffer";
      };
    }
    {
      action = "<cmd>Bdelete<cr>";
      key = "<leader>bc";
      mode = [ "n" ];
      options = {
        desc = "Close buffer";
      };
    }
    {
      action = "<cmd>BufferLinePick<cr>";
      key = "<leader>bp";
      mode = [ "n" ];
      options = {
        desc = "Pick buffer";
      };
    }
    {
      action = "<cmd>BufferLinePickClose<cr>";
      key = "<leader>bk";
      mode = [ "n" ];
      options = {
        desc = "Pick & close buffer";
      };
    }
    {
      action = "<cmd>BufferLineGroupClose ungrouped<cr>";
      key = "<leader>bx";
      mode = [ "n" ];
      options = {
        desc = "Close non-pinned buffers";
      };
    }
    {
      action = "<cmd>BufferLineCloseOthers<cr>";
      key = "<leader>bo";
      mode = [ "n" ];
      options = {
        desc = "Close other buffers";
      };
    }
    {
      action = "<cmd>BufferLineTogglePin<cr>";
      key = "<leader>bt";
      mode = [ "n" ];
      options = {
        desc = "Toggle pin";
      };
    }
  ];
}
