{ lib, ... }: {
  lsp.servers.qmlls = {
    enable = true;
    packageFallback = true;
    config = {
      capabilities = {
        textDocument.semanticTokens = lib.mkRaw "vim.nil";
        workspace.semanticTokes = lib.mkRaw "vim.nil";
      };
    };
  };
}
