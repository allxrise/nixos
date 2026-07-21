_:
let
  fontPkgs = pkgs: [
    pkgs.dejavu_fonts
    pkgs.fira-code
    pkgs.hack-font
    pkgs.ibm-plex
    pkgs.inconsolata
    pkgs.jetbrains-mono
    pkgs.liberation_ttf
    pkgs.nerd-fonts.iosevka
    pkgs.noto-fonts
    pkgs.roboto
    pkgs.roboto-mono
    pkgs.source-code-pro
    pkgs.ttf_bitstream_vera
  ];
in
{
  den.aspects.fonts = {
    nixos =
      { pkgs, ... }:
      {
        fonts.packages = fontPkgs pkgs;
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = fontPkgs pkgs;
        fonts.fontconfig.enable = true;
      };
  };
}
