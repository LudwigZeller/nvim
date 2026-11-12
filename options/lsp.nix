{ pkgs, lib, ... }:
{
  imports = [ ./lsp-servers ];
  lsp = {
    codelens.enable = true;
    completion.enable = false; # Managed by blink.nvim
    documentColor = {
      enable = true;
      settings = {
        style = "background";
      };
    };
    inlayHints.enable = true;
    inlineCompletion.enable = false; # Also handled by blink.nvim
    linkedEditingRange.enable = true;
    onTypeFormatting.enable = true;
    semanticTokens.enable = true;

    # keymaps = [
    #   {
    #     key = "gd";
    #     action = "<cmd>lua vim.lsp.buf.definition()<CR>";
    #     mode = "n";
    #   }
    #   {
    #     key = "gD";
    #     action = "<cmd>lua vim.lsp.buf.references()<CR>";
    #     mode = "n";
    #   } # Fixed g<s-d>
    #   {
    #     key = "gt";
    #     action = "<cmd>lua vim.lsp.buf.type_definition()<CR>";
    #     mode = "n";
    #   }
    #   {
    #     key = "gi";
    #     action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
    #     mode = "n";
    #   }
    #   {
    #     key = "K";
    #     action = "<cmd>lua vim.lsp.buf.hover()<CR>";
    #     mode = "n";
    #   } # Fixed <s-k>
    #   {
    #     key = "<leader>ca";
    #     action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
    #     mode = "n";
    #   }
    #   {
    #     key = "<leader>ck";
    #     action = "<cmd>lua vim.diagnostic.jump({ count=-1, float=true })<CR>";
    #     mode = "n";
    #     options.desc = "Previous diagnostic";
    #   }
    #   {
    #     key = "<leader>cj";
    #     action = "<cmd>lua vim.diagnostic.jump({ count=1, float=true })<CR>";
    #     mode = "n";
    #     options.desc = "Next diagnostic";
    #   }
    # ];
  };
}
