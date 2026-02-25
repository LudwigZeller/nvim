{ ... }:
{
  globals = {
    neovide_animation_lenght = 0.3;
    neovide_confirm_quit = true;
    neovide_cursor_animate_command_line = true;
    neovide_cursor_animation_length = 0.075;
    neovide_cursor_antialiasing = true;
    neovide_cursor_trail_size = 0.8;
    neovide_cursor_unfocused_outline_width = 0.05;
    neovide_cursor_vfx_mode = "ripple";
    neovide_window_blurred = true;
    neovide_floating_blur_amount_x = 2.0;
    neovide_floating_blur_amount_y = 2.0;
    neovide_fullscreen = false;
    neovide_hide_mouse_when_typing = true;
    neovide_no_idle = false;
    neovide_padding_bottom = 0;
    neovide_padding_left = 0;
    neovide_padding_right = 0;
    neovide_padding_top = 0;
    neovide_profiler = false;
    neovide_refresh_rate = 60;
    neovide_refresh_rate_idle = 5;
    neovide_opacity = 0.8;
    neovide_remember_window_size = true;
    neovide_theme = "auto";
    # neovide_underline_automatic_scaling = true;
  };
}
# vim.o.guifont = "FiraCode_Nerd_Font_Mono,Noto_Color_Emoji:#e-subpixelantialias"
# local fontsize = 10
# local function set_font(fontsize)
#   vim.o.guifont = ("FiraCode_Nerd_Font_Mono,Noto_Color_Emoji:h%d:#e-subpixelantialias"):format(fontsize)
# end
#
# vim.keymap.set("n", "<leader>u+", function()
#   if vim.g.neovide_transparency <= 1 then
#     vim.g.neovide_transparency = vim.g.neovide_transparency + 0.1
#   end
# end, { desc = "Increase Transparency" })
#
# vim.keymap.set("n", "<leader>->", function()
#   if vim.g.neovide_transparency >= 0 then
#     vim.g.neovide_transparency = vim.g.neovide_transparency - 0.1
#   end
# end, { desc = "Decrease Transparency" })
#
#
# vim.keymap.set("n", "<C-ScrollWheelUp>", function()
#   fontsize = fontsize - 1
#   set_font(fontsize)
# end, { desc = "which_key_ignore" })
#
# vim.keymap.set("n", "<C-ScrollWheelDown>", function()
#   if fontsize > 1 then
#     fontsize = fontsize + 1
#     set_font(fontsize)
#   end
# end, { desc = "which_key_ignore" })
#
# vim.keymap.set("n", "<leader>vf", function()
#   vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
# end, { desc = "Fullscreen" })
