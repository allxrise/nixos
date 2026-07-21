_: {
  den.aspects.fish.homeManager = { pkgs, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        any-nix-shell fish --setup | source
      '';
    };
    home.packages = [
      pkgs.any-nix-shell
    ];
  };
}
