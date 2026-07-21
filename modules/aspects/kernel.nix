{ lib, inputs, ... }:
{
  den.aspects.system.linux-kernel = {
    nixos =
      { host, pkgs, ... }:
      {
        boot.kernelPackages = pkgs.linuxPackages_zen;
      };
  };
}
