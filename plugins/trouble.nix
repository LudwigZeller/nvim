{ ... }:
{
  plugins.trouble = {
    enable = true;
    lazyLoad.settings = {
      cmd = [
        "Trouble"
      ];
      keys = [
        {
          __unkeyed-1 = "<leader>cx";
          __unkeyed-3 = "<cmd>Trouble<cr>";
          desc = "Toggle Trouble";
        }
        {
          __unkeyed-1 = "<leader>c<s-d>";
          __unkeyed-3 = "<cmd>Trouble workspace_diagnostics<cr>";
          desc = "Workspace Diagnostics";
        }
        {
          __unkeyed-1 = "<leader>cd";
          __unkeyed-3 = "<cmd>Trouble document_diagnostics<cr>";
          desc = "Document Diagnostic";
        }
        {
          __unkeyed-1 = "<leader>cq";
          __unkeyed-3 = "<cmd>Trouble quickfix<cr>";
          desc = "Quickfix";
        }
        {
          __unkeyed-1 = "<leader>cl";
          __unkeyed-3 = "<cmd>Trouble loclist<cr>";
          desc = "Location List";
        }
      ];
    };
  };
}
