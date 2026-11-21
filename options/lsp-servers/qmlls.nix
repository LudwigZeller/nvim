{ lib, ... }: {
  lsp.servers.qmlls = {
    enable = true;
    packageFallback = false;
    config = {
      on_init = lib.mkRaw ''
        function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end
      '';

    };
  };
}
