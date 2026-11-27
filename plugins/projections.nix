{ lib, ... }: {
  # TODO: Dont autoload, but enable dash before reopening the session
  plugins.projections = {
    enable = true;
    settings = {
      workspaces = [
        [
          "~/projects/"
          [ ]
        ]
      ];
      store_hooks.pre = lib.nixvim.mkRaw ''
        function()
          if not package.loaded["neo-tree"] then
            return
          end

          vim.cmd("silent! Neotree action=close")
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == "neo-tree" then
              pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end
          end
        end
      '';
    };
    lazyLoad.settings = {
      after = lib.nixvim.mkRaw ''
        function ()
          local switcher = require("projections.switcher")
          local original_switch = switcher.switch

          switcher.switch = function(project_path)
            original_switch(project_path)
            vim.api.nvim_exec_autocmds("DirChanged", { pattern = "global" })
          end
        end
      '';
    };
  };

  extraConfigLuaPre = ''
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Restore project session if present",
      callback = function()
        if vim.fn.argc() ~= 0 then
          return
        end
        require("lz.n").trigger_load("projections")
        require("projections.session").restore(vim.uv.cwd())
      end,
    })
  '';

  autoCmd = [
    {
      desc = "Save project session on close";
      event = [ "VimLeavePre" ];
      callback = lib.nixvim.mkRaw ''
        function()
          require("lz.n").trigger_load("projections")
          require("projections.session").store(vim.uv.cwd())
        end
      '';
    }
  ];
}
