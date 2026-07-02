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
        end
      '';
      # restore_hooks = {
      #   post = lib.nixvim.mkRaw ''
      #     function()
      #       vim.api.nvim_exec_autocmds("DirChanged", { pattern = "global" })
      #     end
      #   '';
      # };
    };
  };
  autoCmd = [
    {
      desc = "Save project on close";
      event = [
        "VimLeavePre"
      ];
      callback = lib.nixvim.mkRaw ''
        function()
          local session = require("projections.session")
          if SessionUtils.is_project(vim.loop.cwd()) then
            session.store(vim.loop.cwd())
          end
        end
      '';
    }
    {
      desc = "Load project if present";
      event = [
        "VimEnter"
      ];
      callback = lib.nixvim.mkRaw ''
        function()
          local switcher = require("projections.switcher")
          if vim.fn.argc() == 0 then switcher.switch(vim.loop.cwd()) end
        end
      '';
    }
  ];
  extraConfigLua = ''
    local switcher = require("projections.switcher")
    local original_switch = switcher.switch
    local session = require("projections.session")

    _G.SessionUtils = {}
    _G.SessionUtils.is_project = function(target_path)
      -- Ensure path has a trailing slash for clean concatenation
      if not target_path:match("[/\\]$") then target_path = target_path .. "/" end

      local Workspace = require("projections.workspace")
      
      for _, ws in ipairs(Workspace.get_workspaces()) do
        local ws_path = tostring(ws.path)

        -- If the target path sits inside a registered workspace
        if vim.startswith(target_path, ws_path) and target_path ~= ws_path then
          
          -- If the workspace has no patterns (e.g., []), ANY folder is a project
          if next(ws.patterns) == nil then return true end

          -- Otherwise, check if any of the workspace's patterns exist in the target path
          for _, pattern in ipairs(ws.patterns) do
            if vim.fn.isdirectory(target_path .. pattern) == 1 or vim.fn.filereadable(target_path .. pattern) == 1 then
              return true
            end
          end
        end
      end

      return false
    end

    switcher.switch = function(project_path)
      if SessionUtils.is_project(vim.loop.cwd()) then
        session.store(vim.loop.cwd())
      end
      original_switch(project_path)
      vim.api.nvim_exec_autocmds("DirChanged", { pattern = "global" })
    end
  '';
}
