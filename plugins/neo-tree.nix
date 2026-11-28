{ lib, pkgs, ... }:
{
  # plugins.image.enable = true;
  extraPlugins = with pkgs.vimPlugins; [
    nvim-lsp-file-operations
    nvim-window-picker
  ];

  extraConfigLua = ''
    for _, arg in ipairs(vim.fn.argv()) do
      if vim.fn.isdirectory(arg) then
        require("lz.n").trigger_load("neo-tree.nvim")
        break
      end
    end
  '';
  plugins.neo-tree = {
    enable = true;
    settings = {
      filesystem = {
        follow_current_file = {
          enabled = true;
          leave_dirs_open = false;
        };
      };
      filesystem = {
        bind_to_cwd = true;
        hijack_netrw_behavior = "open_current"; # Options: "open_current", "open_default", "disabled"
        use_libuv_file_watcher = true; # Better performance for large projects
      };
      close_if_last_window = true;
      popup_border_style = "rounded";
      enable_git_status = true;
      enable_diagnostics = true;
      window = {
        position = "float";
        width = 80;
      };
      file_size = {
        enabled = true;
        required_width = 64;
      };
      last_modified = {
        enabled = true;
        required_width = 88;
      };
      created = {
        enabled = true;
        required_width = 110;
      };
      type = {
        enabled = true;
        required_width = 122;
      };
    };
    lazyLoad.settings = {
      cmd = "Neotree";
      keys = [
        {
          __unkeyed-1 = "<leader>ft";
          __unkeyed-3 = "<CMD>Neotree toggle<CR>";
          desc = "File Tree";
        }
      ];
      before = lib.nixvim.mkRaw ''
        function ()
          require("lsp-file-operations").setup({ display_operations = true })
          require("window-picker").setup({})
        end
      '';
    };
  };
  keymaps = [
  ];
}
