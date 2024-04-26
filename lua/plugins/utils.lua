return {
  {
    ft = "lua",
    "folke/neodev.nvim",
  },

  { 'ThePrimeagen/vim-be-good', },

  --[[ DevDocs ]]
  {
    "luckasRanarison/nvim-devdocs",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      dir_path = vim.fn.stdpath("data") .. "/devdocs", -- installation directory
      telescope = {},                                  -- passed to the telescope picker
      float_win = {                                    -- passed to nvim_open_win(), see :h api-floatwin
        relative = "editor",
        height = 30,
        width = 140,
        border = "rounded",
      },
      wrap = false,                                   -- text wrap, only applies to floating window
      previewer_cmd = "glow",                         -- for example: "glow"
      cmd_args = { "-s", "dark", "-w", "80", "-l", }, -- example using glow: { "-s", "dark", "-w", "80" }
      cmd_ignore = {},                                -- ignore cmd rendering for the listed docs
      picker_cmd = false,                             -- use cmd previewer in picker preview
      picker_cmd_args = { "-p", "-l", },              -- example using glow: { "-p" }
      ensure_installed = {},                          -- get automatically installed
    }
  },

  --[[ Window Layout after Bufferclose ]]
  { "famiu/bufdelete.nvim",     cmd = { "Bdelete", "Bwipeout" } },

  --[[ Flash ]]
  {
    "folke/flash.nvim",
    opts = { modes = { char = { enabled = false } } },
    -- keys = {
    --   { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash", },
    --   { "F", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
    --   { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash", },
    --   {
    --     "R",
    --     mode = { "o", "x" },
    --     function() require("flash").treesitter_search() end,
    --     desc = "Treesitter Search",
    --   },
    --   {
    --     "<c-s>",
    --     mode = { "c" },
    --     function() require("flash").toggle() end,
    --     desc = "Toggle Flash Search",
    --   },
    -- },
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  --[[ Nvim Surround ]]
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration h
        aliases = {
          ["a"] = ">",
          ["b"] = ")",
          ["B"] = "}",
          ["r"] = "]",
          ["q"] = { '"', "'", "`" },
          ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
        },
        highlight = {
          duration = 100,
        },
        move_cursor = "begin",
      })
    end,
  },

  --[[ Comment ]]
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = "gcc",
          block = "gbc",
        },
        opleader = {
          line = "gc",
          block = "gb",
        },
        extra = {
          above = "gcO",
          below = "gco",
          eol = "gcA",
        },
        mappings = {
          basic = true,
          extra = true,
        },
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },

  --[[ Session Management ]]
  {
    "Shatur/neovim-session-manager",
    cmd = "SessionManager",
    keys = {
      { "<leader>qs", "<cmd>SessionManager save_current_session<cr>", desc = "Save current Session" },
      {
        "<leader>qr",
        "<cmd>SessionManager load_current_dir_session<cr>",
        desc = "Restore Session based on CWD",
      },
      { "<leader>ql", "<cmd>SessionManager load_session<cr>",         desc = "List Sessions" },
      { "<leader>qo", "<cmd>SessionManager load_last_session<cr>",    desc = "Load last Sessions" },
      { "<leader>qx", "<cmd>SessionManager delete_session<cr>",       desc = "Delete Sessions" },
    },
    config = function()
      local config = require("session_manager.config")
      require("session_manager").setup({
        sessions_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        autoload_mode = config.AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true,                   -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true,              -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_dirs = {},                      -- A list of directories where the session will not be autosaved.
        autosave_ignore_filetypes = {                   -- All buffers of these file types will be closed before the session is saved.
          "gitcommit",
          "gitrebase",
        },
        autosave_ignore_buftypes = {},   -- All buffers of these bufer types will be closed before the session is saved.
        autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 80,            -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
      })
    end,
  },

  --[[ Scope ]]
  {
    "tiagovla/scope.nvim",
    config = true,
  },

  --[[ Improved Macros ]]
  {
    "chrisgrieser/nvim-recorder",
    event = "VeryLazy",
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {                               -- startup.
      slots = { "a", "b", "c" },
      clear = true,
      lessNotifications = true,
    }, -- required even with default settings, since it calls `setup()`
  },

  --[[ makes plugins dot-repeatable ]]
  { "tpope/vim-repeat", event = "VeryLazy" },
}
