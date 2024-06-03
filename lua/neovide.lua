vim.o.guifont = "FiraCode_Nerd_Font_Mono,Noto_Color_Emoji:#e-subpixelantialias"
local fontsize = 10
local function set_font(fontsize)
  vim.o.guifont = ("FiraCode_Nerd_Font_Mono,Noto_Color_Emoji:h%d:#e-subpixelantialias"):format(fontsize)
end

vim.g.neovide_animation_lenght = 0.3
vim.g.neovide_confirm_quit = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_animation_length = 0.075
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_unfocused_outline_width = 0.05
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_window_blurred = true;
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_fullscreen = false
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_no_idle = false
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_left = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_top = 0
vim.g.neovide_profiler = false
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_transparency = 0.8
vim.g.neovide_remember_window_size = true
vim.g.neovide_theme = "auto"
-- vim.g.neovide_underline_automatic_scaling = true

vim.keymap.set("n", "<leader>u+", function()
  if vim.g.neovide_transparency <= 1 then
    vim.g.neovide_transparency = vim.g.neovide_transparency + 0.1
  end
end, { desc = "Increase Transparency" })

vim.keymap.set("n", "<leader>->", function()
  if vim.g.neovide_transparency >= 0 then
    vim.g.neovide_transparency = vim.g.neovide_transparency - 0.1
  end
end, { desc = "Decrease Transparency" })


vim.keymap.set("n", "<C-ScrollWheelUp>", function()
  fontsize = fontsize - 1
  set_font(fontsize)
end, { desc = "which_key_ignore" })

vim.keymap.set("n", "<C-ScrollWheelDown>", function()
  if fontsize > 1 then
    fontsize = fontsize + 1
    set_font(fontsize)
  end
end, { desc = "which_key_ignore" })

vim.keymap.set("n", "<leader>vf", function()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end, { desc = "Fullscreen" })
