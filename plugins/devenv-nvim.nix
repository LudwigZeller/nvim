{ lib, ... }: {
  autoCmd = [
    {
      event = "DirChanged";
      callback = lib.nixvim.mkRaw "";
    }
  ];
  extraFiles."/lua/devenv.lua".text = /* lua */ ''
    local M = { devenv_paths = {} }

    M.status = function() end

    M.load_devenv = function()
    	local path = vim.fs.root(0, { "devenv.nix" })
    	if not path then
    		vim.notify("No direnv detected")
    		return
    	end
    	if not vim.secure.read(path .. "/devenv.nix") then
    		vim.notify("Project was not trusted, did not load devenv")
    		return
    	end
    	local cmd = { "sh", "-c", "devenv shell -- sh -c 'env -0 >&3' 3>&1 1>/dev/null 2>/dev/null" }
    	vim.system(cmd, { text = true }, function(out)
    		local new_env = vim.split(out.stdout, "\0", { plain = true })
    		vim.print("Extracted devenv env")
    		new_env = vim.iter(new_env):fold({}, function(acc, v)
    			local entry = vim.split(v, "=", { plain = true })
    			acc[entry[1]] = entry[2]
    			return acc
    		end)
    		new_env = vim.iter(new_env):filter(function(k, v)
    			return vim.stricmp(vim.env[k], v) ~= 0
    		end)
    		vim.print(new_env)
    	end)
    end

    function unload_devenv() end

    return M
  '';
}
