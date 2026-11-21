{ lib, ... }: {
  lsp.servers.qmlls = {
    enable = true;
    packageFallback = true;
    config = {
      capabilities = {
        textDocument.semanticTokens = lib.nixvim.mkRaw "vim.nil";
        workspace.semanticTokes = lib.nixvim.mkRaw "vim.nil";
      };
    };
  };
}
