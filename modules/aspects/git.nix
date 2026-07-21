_: {
  den.aspects.git.homeManager =
    { config, ... }:
    {
      programs.git = {
        enable = true;
        lfs.enable = true;
        signing = {
          format = "ssh";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID8jdoPNyJHT2LriBgmVYKgLut6Hx7xiKfosP7EDZtLc iso@lappers";
          signByDefault = true;
        };
        ignores = [
          "result"
          "*.swp"
          "*.qcow2"
        ];
        settings = {
          user = {
            name = "AllxRise";
            email = "dahilege@gmail.com";
          };
          alias = {
            s = "status";
            d = "diff";
            a = "add";
            c = "commit";
            p = "push";
            co = "checkout";
          };
          init.defaultBranch = "main";
          pull.rebase = false;
          commit.gpgsign = true;
          gpg.format = "ssh";
        };
      };
    };
}
