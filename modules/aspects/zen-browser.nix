{ inputs, ... }: {
  den.aspects.zen-browser.homeManager = _: {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };
    };
  };
}
