_: {
  den.aspects.ghostty = {
    homeManager = { pkgs, ... }: {
      programs.ghostty = {
        enable = true;
      };
    };
  };
}
