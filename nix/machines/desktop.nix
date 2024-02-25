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
  hardware.nvidia.package = pkgs.linuxKernel.packages.linux_6_1.nvidia_x11;
  hardware.nvidia.modesetting.enable = true;
  environment.systemPackages = with pkgs; [ ];

  hardware.bluetooth.enable = true;

  # specific programs
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  networking.networkmanager.enable = true;

  security.polkit.enable = true;
}
