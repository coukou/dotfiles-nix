{ ... }: {
  flake.modules.nixos.hardware-xps13 = { config, lib, modulesPath, ... }: {
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    networking.hostName = "coukou";

    boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/22e1c21f-7442-4f30-a267-0a2ac5829e9b";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/022E-3BAA";
      fsType = "vfat";
    };

    swapDevices = [{ device = "/dev/disk/by-uuid/fd87a6b2-3fab-48c6-86d8-646ff3d2adb2"; }];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
