{ lib, ... }: {
  autoCmd = [
    {
      event = [
        "DirChanged"
        "VimEnter"
      ];
      callback = lib.nixvim.mkRaw ''
        function ()
        	local devenv = require("devenv")
        	local path = devenv.find_root()

        	if path == devenv.loaded_devenv then
        		return
        	end

        	devenv.unload()

        	if not path then
        		return
        	end

        	if path and devenv.auto_load and not vim.secure.read(path .. "/devenv.nix") then
        		vim.notify("devenv.nix is not trusted, did not load devenv", vim.log.levels.WARN)
        	else
        		devenv.load()
        	end
        end
      '';

    }
  ];

  userCommands = {
    Devenv = {
      command = lib.nixvim.mkRaw ''
        function (opts)
        	local args = vim.split(opts.args, "%s+")
        	local subcmd = args[1]
        	local param = args[2]
        	local devenv = require("devenv")

        	if subcmd == "load" then
        		devenv.load()
        	elseif subcmd == "unload" then
        		devenv.unload()
        	elseif subcmd == "autoload" then
        		if param == "on" then
        			devenv.auto_load = true
        		elseif param == "off" then
        			devenv.auto_load = false
        		elseif param == "toggle" then
        			devenv.auto_load = not devenv.auto_load
        		end
        	else
        		vim.notify("Unknown command, usage: Devenv [load|unload|autoload [on|off|toggle]]", vim.log.levels.ERROR)
        	end
        end
      '';
      nargs = "*";
      complete = lib.nixvim.mkRaw ''
        function (arglead, cmdline, cursorpos)
            local words = vim.split(cmdline, "%s+", { trimempty = false })
            local matches = {}

            if #words == 2 then
                local choices = { "load", "unload", "autoload" }
                for _, choice in ipairs(choices) do
                    if vim.startswith(choice, arglead) then
                        table.insert(matches, choice)
                    end
                end

            elseif #words == 3 and words[2] == "autoload" then
                local choices = { "on", "off", "toggle" }
                for _, choice in ipairs(choices) do
                    if vim.startswith(choice, arglead) then
                        table.insert(matches, choice)
                    end
                end
            end

            return matches
        end
      '';
      desc = "Neovim devenv.nix integration";
    };
  };
  extraFiles."/lua/devenv.lua".text = /* lua */ ''
    local M = {
    	loaded_devenv = nil,
    	auto_load = true,
    	devev_status = "unloaded",
    	special_env_keys = { "PATH", "XDG_DATA_DIRS" },
    	devenv = {
    		added_env = {},
    		modified_env = {},
    	},
    }

    M.status = function()
    	return M.devev_status
    end

    M.find_root = function()
    	local path = vim.fs.root(0, { "devenv.nix" })
    	if not path then
    		return nil
    	end
    	return path
    end

    M.load = function()
    	M.devev_status = "loading"

    	local path = M.find_root()
    	if not path then
    		vim.notify("Did not find any devenv.nix root", vim.log.levels.ERROR)
    		M.devev_status = "unloaded"
    		return
    	end

    	local cmd = { "sh", "-c", "devenv shell -- sh -c 'env -0 >&3' 3>&1 1>/dev/null 2>/dev/null" }
    	vim.system(cmd, { text = true }, function(out)
    		local devenv = vim.split(out.stdout, "\0", { plain = true })
    		devenv = vim.iter(devenv):fold({}, function(acc, v)
    			local delimiter = string.find(v, "=", 1, true)
    			if not delimiter then
    				return acc
    			end
    			acc[string.sub(v, 1, delimiter - 1)] = string.sub(v, delimiter + 1)
    			return acc
    		end)
    		vim.schedule(function()
    			local modified_entries = vim.iter(devenv)
    				:filter(function(k, v)
    					return vim.env[k] ~= nil and vim.stricmp(v, vim.env[k]) ~= 0
    				end)
    				:fold({}, function(acc, k, v)
    					acc[k] = v
    					return acc
    				end)
    			local new_entries = vim.iter(devenv)
    				:filter(function(key, _)
    					return vim.env[key] == nil
    				end)
    				:fold({}, function(acc, k, v)
    					acc[k] = v
    					return acc
    				end)

    			vim.iter(new_entries):each(function(key, value)
    				vim.env[key] = value
    				M.devenv.added_env[key] = value
    			end)

    			vim.iter(modified_entries):each(function(key, val)
    				if vim.list_contains(M.special_env_keys, key) then
    					-- PREPEND
    					local index = string.find(val, vim.env[key], 1, true)
    					local pre = string.sub(val, 1, index - 1)
    					local post = string.sub(val, index + #vim.env[key])

    					vim.env[key] = pre .. vim.env[key] .. post

    					M.devenv.modified_env[key] = { pre, post }
    					-- M.devenv.modified_env[key].pre = pre
    					-- M.devenv.modified_env[key].post = post
    				else
    					-- OVERWRITE
    					M.devenv.modified_env[key] = vim.env[key]
    					vim.env[key] = val
    				end
    			end)

    			M.devev_status = "loaded"
    			M.loaded_devenv = path
    		end)
    	end)
    end

    M.unload = function()
    	M.devev_status = "unloading"
    	vim.iter(M.devenv.added_env):each(function(key, _)
    		vim.env[key] = nil
    		M.devenv.added_env[key] = nil
    	end)
    	vim.iter(M.devenv.modified_env):each(function(key, val)
    		if vim.list_contains(M.special_env_keys, key) then
    			vim.iter(val):each(function(mod)
    				local index = string.find(vim.env[key], mod, 1, true)
    				vim.env[key] = string.sub(vim.env[key], 1, index - 1) .. string.sub(vim.env[key], index + #mod)
    			end)
    		else
    			vim.env[key] = val
    		end
    		M.devenv.modified_env = nil
    	end)
    	M.devev_status = "unloaded"
    	M.loaded_devenv = nil
    end

    return M
  '';

}
