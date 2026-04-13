{ ... }: {
  flake.modules.nixos.hardware-desktop = { config, lib, modulesPath, ... }: {
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    networking.hostName = "coukou";

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/1014d251-9d9f-4dfb-9c28-66f5a9ba4377";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/4F82-1448";
      fsType = "vfat";
    };

    swapDevices = [ ];

    networking.useDHCP = lib.mkDefault true;
    networking.nameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 3000 5037 11434 ];
      allowedTCPPortRanges = [{ from = 8000; to = 8100; }];
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
