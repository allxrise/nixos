_: {
	den.aspects.syspkg.nixos =
	{ pkgs,  ... }:
	{
		environment.systemPackages = [
			pkgs.age
			pkgs.fd
			pkgs.fzf
			pkgs.pciutils
			pkgs.ripgrep
			pkgs.ssh-to-age
			pkgs.sops
			pkgs.unzip
			pkgs.kdePackages.partitionmanager
		];
	};
}
