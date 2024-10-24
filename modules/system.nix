{ pkgs, inputs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Istanbul";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    #alsa.enable = true;
    #alsa.support32Bit = true;
  };

  users.users.iso = {
    isNormalUser = true;
    description = "Iso";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    neovim 
    lunarvim
    wget
    git
    sops
    age
    corefonts
    vistafonts
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
    nvidia-vaapi-driver
  ];

  programs.steam.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["Iosevka"]; })
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";
}
