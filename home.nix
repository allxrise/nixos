{ pkgs, ... }:
{
  home.username = "iso";

  home.packages = with pkgs; [
    # Desktop
    kdePackages.kate
    kdePackages.ktorrent
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    bottles
    flatpak
    gnome-software
    element-desktop
    vlc

    # Dev
    lazygit
    gh
    wl-clipboard

    # Jetbrains
    jetbrains.rust-rover
    jetbrains.clion
    jetbrains.rider
    jetbrains.idea-ultimate
  ];

  systemd.user.sessionVariables = {
    EDITOR = "lvim";
  };

  programs.firefox.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "AllxRise";
    userEmail = "dahilege@gmail.com";
  };

  programs.kitty = {
    enable = true;
    environment = {
      "EDITOR" = "lvim";
    };
    font = {
      name = "Iosevka Nerd Font";
      package = (pkgs.nerdfonts.override { fonts = ["Iosevka"]; });
    };
    theme = "Gruvbox Material Dark Medium";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = 
    ''
    vpn-down() {
      systemctl stop wg-quick-mullvad
      systemctl stop wg-quick-umut
    }

    umut-up() {
      systemctl start wg-quick-umut
    }

    mullvad-up() {
      systemctl start wg-quick-mullvad
    }
    '';
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      vim-tmux-navigator
    ];
    extraConfig = 
    ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g mouse on
      
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix
      
      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D 
      bind k select-pane -U
      bind l select-pane -R
      
      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on
      
      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
      
      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window
      
      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window
      
      run '~/.tmux/plugins/tpm/tpm'
      
      # set vi-mode
      set-window-option -g mode-keys vi
      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
