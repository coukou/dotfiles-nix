{ config, pkgs, ... }: {
  imports = [
    ./hardware/desktop.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 30;
  };

  boot.kernelParams = [ "nvidia_drm.fbdev=1" "nvidia-drm.modeset=1" ];

  networking.hostName = "coukou";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver =
    {
      videoDrivers = [ "nvidia" ];
    };


  hardware.nvidia = {
    forceFullCompositionPipeline = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  environment.systemPackages = [ ];

  hardware.bluetooth.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
  };

  # specific programs
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  networking.networkmanager.enable = true;

  security.polkit.enable = true;

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
