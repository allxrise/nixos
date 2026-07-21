{ inputs, ... }:
{
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-file.url = "github:vic/flake-file";
    den.url = "github:denful/den";
    zen-browser = {
	url = "github:0xc000022070/zen-browser-flake";
    inputs = {
      # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
    };
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
        antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };
}
