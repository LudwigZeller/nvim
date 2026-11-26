{ ... }:
{
  plugins.nvim-surround = {
    enable = true;
    lazyLoad.settings = {
      event = "InsertEnter";
    };
  };
}
