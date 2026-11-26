{ ... }: {
  plugins.precognition = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";
  };
}
