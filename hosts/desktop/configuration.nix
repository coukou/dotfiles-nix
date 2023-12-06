{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.coukou = {
    isNormalUser = true;
    description = "coukou";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Enable polkit
  security.polkit.enable = true;

  # 1Password, TODO: Move this somewhere else
  # programs._1password.enable = true;
  # programs._1password-gui = {
  #  enable = true;
  #  polkitPolicyOwners = [ "coukou" ];
  # };

  # Version
  system.stateVersion = "23.11";
}
