{ inputs, ... }:
{
  den.aspects.antigravity = {
    homeManager = {
      pkgs,
      ...
    }: {
      home.packages = [
        inputs.antigravity-nix.packages.${pkgs.system}.google-antigravity-cli
      ];
    };
  };
}
