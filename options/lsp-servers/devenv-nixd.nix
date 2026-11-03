{ lib, ... }: {
  ####################
  ###    devenv    ###
  ####################
  filetype.filename."devenv.nix" = "devenv";
  plugins.treesitter.languageRegister.nix = [ "devenv" ];
  autoCmd = [
    {
      event = "FileType";
      pattern = "devenv";
      desc = "Start local devenv lsp";
      callback = lib.nixvim.mkRaw ''
        function(ev)
          local root_dir = vim.fs.root(ev.buf, { "devenv.nix" })
          if not root_dir then return end
          vim.system({'devenv', '--quiet', 'lsp', '--print-config'}, { cwd = root_dir, text = true }, function(obj)
            if obj.code == 0 and obj.stdout then
              vim.schedule(function()
                local ok, devenv_settings = pcall(vim.json.decode, obj.stdout)
                if ok and devenv_settings then
                  local nixd_settings = vim.deepcopy(vim.lsp.config.nixd.settings) or { nixd = {} }
                  -- nixd_settings = { nixd = {}}
                  nixd_settings.nixd.nixpkgs = vim.deepcopy(devenv_settings.nixd.nixpkgs)
                  nixd_settings.nixd.options = vim.deepcopy(devenv_settings.nixd.options)
                  vim.lsp.start({
                    name = "devenv",
                    settings = nixd_settings,
                    root_dir = root_dir,
                    cmd = { "devenv", "lsp" },
                  }, { bufnr = ev.buf })
                end
              end)
            end
          end)
        end
      '';
    }
  ];
}
