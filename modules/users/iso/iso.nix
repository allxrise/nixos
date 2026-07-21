{
  den,
  ...
}:
{
  den.aspects.iso = {

    includes = [
      den.batteries.primary-user
      (den.batteries.user-shell "fish")

      den.aspects.equibop
      den.aspects.zen-browser
      den.aspects.nvim
      den.aspects.zed
      den.aspects.git
      den.aspects.lazygit
      den.aspects.fish
      den.aspects.antigravity
      den.aspects.claude-code
      den.aspects.codex
      den.aspects.bitwarden-cli
      den.aspects.ghostty

      # den.aspects.android

      den.aspects.resolved
      den.aspects.zapret
    ];

    nixos =
      {
        config,
        ...
      }:
      {
        users.mutableUsers = false;

        sops.secrets."users/iso/password".neededForUsers = true;

        users.users.iso = {
	  isNormalUser = true;
          hashedPasswordFile = config.sops.secrets."users/iso/password".path;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID8jdoPNyJHT2LriBgmVYKgLut6Hx7xiKfosP7EDZtLc iso@lappers"
          ];

          extraGroups = builtins.filter (g: builtins.hasAttr g config.users.groups) [
            "disk"
            "i2c"
            "libvirtd"
            "kvm"
            "video"
            "render"
            "audio"
            "input"
            "plugdev"
            "wheel"
          ];
        };
      };

    homeManager = _: {
      programs.home-manager.enable = true;
      home.sessionPath = [ "$HOME/.local/bin" ];
    };

  };
}
