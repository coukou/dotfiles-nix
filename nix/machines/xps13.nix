{ config, pkgs, self, ... }: {
  imports = [
    ./hardware/xps13.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 30;
  };

  networking.hostName = "coukou";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [ ];

  hardware.bluetooth.enable = true;

  # specific programs
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  networking.networkmanager.enable = true;

  security.polkit.enable = true;

  # Force S3 sleep mode. See README.wiki for details.
  boot.kernelParams = [
    "mem_sleep_default=deep"
    "i915.enable_fbc=1"
    "i915.enable_psr=2"
  ];

  # touchpad goes over i2c
  boot.blacklistedKernelModules = [ "psmouse" ];

  services.throttled.enable = true;

  # This will save you money and possibly your life!
  services.thermald.enable = true;


}
