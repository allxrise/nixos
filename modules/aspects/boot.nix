_: {
  den.aspects.boot.nixos = {
    boot.loader.limine = {
      enable = true;
      maxGenerations = 10;
      extraEntries = ''
        /Windows
              protocol: efi
              path: uuid(3b7f85d9-4188-4b32-821f-c4ab55718c67):/EFI/Microsoft/Boot/bootmgfw.efi
      '';
    };
    boot.loader.efi.canTouchEfiVariables = false;
  };
}
