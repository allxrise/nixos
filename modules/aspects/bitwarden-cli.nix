_: {
  den.aspects.bitwarden-cli = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.bitwarden-cli
      ];
    };
  };
}
