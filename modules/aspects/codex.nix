_: {
  den.aspects.codex = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.codex
      ];
    };
  };
}
