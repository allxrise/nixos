_: {
  den.aspects.fish.homeManager = { pkgs, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        any-nix-shell fish --setup | source

        if status is-interactive; and test -n "$SSH_AUTH_SOCK"
          ssh-add -l >/dev/null 2>&1
          if test $status -eq 1
            ssh-add -q ~/.ssh/id_ed25519 2>/dev/null
          end
        end
      '';
    };
    home.packages = [
      pkgs.any-nix-shell
    ];
  };
}
