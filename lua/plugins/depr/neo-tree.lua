return {
	'nvim-neo-tree/neo-tree.nvim',
	branch = 'v2.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
	},
	--keys = { "n", "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
	opts = {
		close_if_last_window = true,
		source_selector = {
			winbar = false,
			statusline = false
    },

		filesystem = {
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = true,
				hide_gitignored = true,
				hide_hidden = true, -- only works on Windows for hidden files/directories
			},
			follow_current_file = false, -- This will find and focus the file in the active buffer every
																	 -- time the current file is changed while the tree is open.
			group_empty_dirs = false, -- when true, empty folders will be grouped together
			hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
																							-- in whatever position is specified in window.position
														-- "open_current",  -- netrw disabled, opening a directory opens within the
																							-- window like netrw would, regardless of window.position
														-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			use_libuv_file_watcher = false,
		}
	}
}
