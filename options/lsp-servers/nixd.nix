{ lib, ... }: {
  ####################
  ###     nixd     ###
  ####################
  opts.exrc = true; # Enable support for per project nixd config - move if not only used for nixd anymore
  autoCmd = [
    {
      event = "DirChanged";
      callback = lib.nixvim.mkRaw ''
        function()
          local root = vim.fs.root(0, {'.nvim.lua'})
          if not root then return end

          local rc = vim.secure.read(root .. "/.nvim.lua")
          if not rc or rc == true then return end

          local chunk, err = load(rc)
          if chunk then
            chunk()
            vim.notify(".nvim.lua loaded (and will not be unloaded)", vim.log.levels.INFO)
          else
            vim.notify("Error loading .nvim.lua: " .. tostring(err), vim.log.levels.ERROR)
          end
        end
      '';
    }
  ];
  lsp.servers = {
    nixd = {
      enable = true;
      config = {
        settings.nixd = {
          nixpkgs.expr = "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs { }";
          formatting.command = [ "nixfmt" ];
          options = {
            "flake-parts" = {
              expr = ''
                let flake = builtins.getFlake (builtins.toString ./.);
                in if flake ? debug.options then
                  flake.debug.options
                else
                  { }
              '';
            };
            "flake-parts-currentSystem" = {
              expr = ''
                let flake = builtins.getFlake (builtins.toString ./.);
                in if flake ? currentSystem.options then
                  flake.currentSystem.options
                else
                  { }
              '';
            };
          };
        };
      };
    };
  };
}
