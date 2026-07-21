_: {
  den.aspects.devenv = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        devenv
      ];
    };
    nixos = _: {
      programs.direnv = {
        enable = true;
        enableFishIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
