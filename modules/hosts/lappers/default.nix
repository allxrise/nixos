{ den, ... }: {
  den.hosts.x86_64-linux.lappers = {
    settings = {
      system = {
        linux-kernel = {
          channel = "latest";
          optimization = "x86_64-v3";
        };
      };
    };
  };

  den.aspects.lappers = {
    includes = [
      den.aspects.base
      den.aspects.desktop
      den.aspects.gaming
    ];

    nixos =
      { ... }:
      {
        imports = [
          ./_hardware.nix
        ];

        networking = {
          domain = "home.arpa";
          search = [ "home.arpa" ];
        };
      };
  };
}
