{ lib, ... }:
{
  plugins.projections = {
    enable = true;
    settings = {
      workspaces = [
        [
          "~/projects/"
          [ ] # All folders are considered projects
        ]
      ];
      store_hook.pre = lib.nixvim.mkRaw ''
        function ()
          if pcall(require, "neo-tree") then 
            vim.cmd [[Neotree action=close]] 
          end
        end'';
      restore_hooks = {
        post = lib.nixvim.mkRaw ''
          function()
            vim.api.nvim_exec_autocmds("DirChanged", { pattern = "global" })
          end
        '';
      };
    };
  };
  autoCmd = [
    {
      desc = "Save project on close";
      event = "VimLeavePre";
      callback = lib.nixvim.mkRaw ''
        function()
          local session = require("projections.session")
          session.store(vim.loop.cwd())
        end
      '';
    }
    {
      desc = "Load project if present";
      event = "VimEnter";
      callback = lib.nixvim.mkRaw ''
        function()
          local switcher = require("projections.switcher")
          if vim.fn.argc() == 0 then switcher.switch(vim.loop.cwd()) end
        end
      '';
    }
  ];
}
