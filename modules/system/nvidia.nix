{ ... }: {
  flake.modules.nixos.nvidia = { config, ... }: {
    boot.kernelParams = [ "nvidia_drm.fbdev=1" "nvidia-drm.modeset=1" ];
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      forceFullCompositionPipeline = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
    };
  };
}
