{ den, ... }:
{
  den.aspects.base.includes = [
    den.aspects.nix
    den.aspects.unfree
    den.aspects.locale
    den.aspects.ssh
    den.aspects.networking
    den.aspects.hardware
    den.aspects.systemd-initrd
    den.aspects.boot
    den.aspects.system.linux-kernel
    den.aspects.sops
    den.aspects.syspkg
    den.aspects.fonts
    den.aspects.preservation
  ];
}
