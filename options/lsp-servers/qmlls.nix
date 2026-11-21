{ lib, ... }: {
  lsp.servers.qmlls = {
    enable = true;
    packageFallback = true;
    config = {
      capabilities = {
        textDocument.semanticTokens = lib.nixvim.mkRaw "vim.NIL";
        workspace.semanticTokens = lib.nixvim.mkRaw "vim.NIL";
      };
    };
  };
}
