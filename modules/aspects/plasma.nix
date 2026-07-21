_: {
  den.aspects.plasma = {
    nixos =
      { config, lib, ... }:
      let
        normalUser = builtins.head (
          builtins.attrNames (lib.filterAttrs (_: u: u.isNormalUser) config.users.users) ++ [ "iso" ]
        );
      in
      {
        programs.dconf.enable = true;

        xdg.portal.enable = true;

        services = {
          libinput.enable = true;
          desktopManager.plasma6.enable = true;
          displayManager = {
            plasma-login-manager.enable = true;
            autoLogin.user = "${normalUser}";
          };
        };
      };
    homeManager = { pkgs, ... }: {
      programs.partition-manager.enable = true;
      home.packages = [
        pkgs.wl-clipboard
      ];
    };
  };
}
