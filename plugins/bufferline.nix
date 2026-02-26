{ ... }:
{
  plugins = {
    bufferline.enable = true;
    web-devicons.enable = true;
  };
  
  keymaps = [
    # Fast Navigation
    { action = "<cmd>BufferLineCyclePrev<cr>"; key = "<S-h>"; mode = ["n"]; options = { desc = "Prev buffer"; }; }
    { action = "<cmd>BufferLineCycleNext<cr>"; key = "<S-l>"; mode = ["n"]; options = { desc = "Next buffer"; }; }

    # Reordering Buffers
    { action = "<cmd>BufferLineMovePrev<cr>"; key = "<C-S-h>"; mode = ["n"]; options = { desc = "Move buffer left"; }; }
    { action = "<cmd>BufferLineMoveNext<cr>"; key = "<C-S-l>"; mode = ["n"]; options = { desc = "Move buffer right"; }; }

    # Bracket Navigation
    { action = "<cmd>BufferLineCyclePrev<cr>"; key = "[b"; mode = ["n"]; options = { desc = "Prev buffer"; }; }
    { action = "<cmd>BufferLineCycleNext<cr>"; key = "]b"; mode = ["n"]; options = { desc = "Next buffer"; }; }

    # Leader Mappings
    { action = "<cmd>enew<cr>"; key = "<leader>bn"; mode = ["n"]; options = { desc = "New buffer"; }; }
    { action = "<cmd>Bdelete<cr>"; key = "<leader>bc"; mode = ["n"]; options = { desc = "Close buffer"; }; }
    { action = "<cmd>BufferLinePick<cr>"; key = "<leader>bp"; mode = ["n"]; options = { desc = "Pick buffer"; }; }
    { action = "<cmd>BufferLinePickClose<cr>"; key = "<leader>bk"; mode = ["n"]; options = { desc = "Pick & close buffer"; }; }
    { action = "<cmd>BufferLineGroupClose ungrouped<cr>"; key = "<leader>bx"; mode = ["n"]; options = { desc = "Close non-pinned buffers"; }; }
    { action = "<cmd>BufferLineCloseOthers<cr>"; key = "<leader>bo"; mode = ["n"]; options = { desc = "Close other buffers"; }; }
    { action = "<cmd>BufferLineTogglePin<cr>"; key = "<leader>bt"; mode = ["n"]; options = { desc = "Toggle pin"; }; }
  ];
}
