{ inputs, ... }: {
  den.aspects.tidal.homeManager = { pkgs, ... }: {
    home.packages = [ inputs.tidaLuna.packages.${pkgs.system}.default ];
  };
}
