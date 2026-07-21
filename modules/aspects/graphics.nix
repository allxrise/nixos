_: {
	den.aspects.graphics.nixos = _: {
		hardware.graphics = {
			enable = true;
			enable32Bit = true;
		};
		services.xserver.videoDrivers = [ "nvidia" ];
  		hardware.nvidia = {
  		  modesetting.enable = true;

  		  powerManagement.enable = true;
  		  powerManagement.finegrained = false;

  		  open = true;

  		  nvidiaSettings = true;
  		};
	};
}
