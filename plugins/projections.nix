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
          if pcall(require, "neo-tree") then vim.cmd [[Neotree action=close]] end
        end
      '';
    };
  };

  extraConfigLuaPre = ''
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Restore project session if present",
      callback = function()
        if vim.fn.argc() ~= 0 then return end
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
          require("projections.session").store(vim.uv.cwd())
        end
      '';
    }
  ];

  extraConfigLua = ''
    local switcher = require("projections.switcher")
    local original_switch = switcher.switch

    switcher.switch = function(project_path)
      if _G.AlphaAnimTimer then _G.AlphaAnimTimer:stop() end
      original_switch(project_path)
      vim.api.nvim_exec_autocmds("DirChanged", { pattern = "global" })
    end
  '';
}
