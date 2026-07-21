_: {
  den.aspects.system.linux-kernel = {
    nixos =
      { pkgs, ... }:
      {
        boot.kernelPackages = pkgs.linuxPackages_zen;
      };
  };
}
