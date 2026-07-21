_: {
	den.aspects.plasma = {
		nixos = 
			{ pkgs, ... }:
			{
				programs.dconf.enable = true;

				xdg.portal.enable = true;

				services = {
					libinput.enable = true;
					desktopManager.plasma6.enable = true;
					displayManager.plasma-login-manager.enable = true;
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
