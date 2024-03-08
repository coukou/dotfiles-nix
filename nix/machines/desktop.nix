{ config, pkgs, self, ... }: {
  imports = [
    ./hardware/desktop.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "coukou";
  i18n.defaultLocale = "en_US.UTF-8";

  # nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  hardware.nvidia.package =
    config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "550.54.14";
      sha256_64bit = "sha256-jEl/8c/HwxD7h1FJvDD6pP0m0iN7LLps0uiweAFXz+M=";
      openSha256 = "sha256-mRUTEWVsbjq+psVe+kAT6MjyZuLkG2yRDxCMvDJRL1I=";
      settingsSha256 = "sha256-m2rNASJp0i0Ez2OuqL+JpgEF0Yd8sYVCyrOoo/ln2a4=";
      persistencedSha256 = "sha256-11tLSY8uUIl4X/roNnxf5yS2PQvHvoNjnd2CB67e870=";
    };

  environment.systemPackages = with pkgs; [ ];

  hardware.bluetooth.enable = true;

  # specific programs
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  networking.networkmanager.enable = true;

  security.polkit.enable = true;

  # enable docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
