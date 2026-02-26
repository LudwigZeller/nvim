{ ... }:
{
  plugins.dashboard = {
    enable = true;
    settings = {
      hide = {
        statusline = true;
        winbar = true;
        tabline = true;
      };
      config = {
        packages.enable = true;
        mru = {
          enable = true;

        };
      };
    };
  };
}
