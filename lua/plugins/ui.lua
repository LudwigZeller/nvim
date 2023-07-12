return {
	--[[ Statusline ]]--
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'filename'},
				lualine_x = {'location'},
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		}
	},

	--[[ Bufferline ]]--
	{
		'akinsho/bufferline.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {},
	},

	--[[ Winbar ]]--
	{
		'fgheng/winbar.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
		opts = {
			enabled = true,

			show_file_path = true,
			show_symbols = true,

			colors = {
					path = '', -- You can customize colors like #c946fd
					file_name = '',
					symbols = '',
			},

			icons = {
					file_icon_default = '',
					seperator = '>',
					editor_state = '●',
					lock_icon = '',
			},

			exclude_filetype = {
					'help',
					'startify',
					'dashboard',
					'packer',
					'neogitstatus',
					'NvimTree',
					'Trouble',
					'alpha',
					'lir',
					'Outline',
					'spectre_panel',
					'toggleterm',
					'qf',
			}
		}
	},
}
