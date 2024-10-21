{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    sops.url = "github:Mic92/sops-nix";
  };

  outputs = { nixpkgs, ... } @ inputs: 
  # let
  #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
  # in
  {
    nixosConfiguration.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hardware-configuration.nix
        ./modules/system.nix
        ./modules/networking.nix
        ./modules/nvidia.nix
        ./modules/user.nix
        ./modules/wireguard.nix
      ];
    };
  };
}
