{ lib, ... }: {
  plugins.projections = {
    enable = true;
    settings = {
      workspaces = [
        [
          "~/projects/"
          [ ]
        ]
      ];
      store_hook.pre = lib.nixvim.mkRaw ''
        function()
          vim.cmd("Neotree action=close")
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == "snacks_dashboard" then
              pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end
          end
        end
      '';
    };
  };

  autoCmd = [
    {
      desc = "Save project session on close";
      event = [ "VimLeavePre" ];
      callback = lib.nixvim.mkRaw ''
        function()
          require("projections.session").store(vim.uv.cwd())
        end
      '';
    }
  ];

  extraConfigLua = ''
    local switcher = require("projections.switcher")
    local original_switch = switcher.switch

    switcher.switch = function(project_path)
      original_switch(project_path)
      vim.api.nvim_exec_autocmds("DirChanged", { pattern = "global" })
    end
  '';
}
