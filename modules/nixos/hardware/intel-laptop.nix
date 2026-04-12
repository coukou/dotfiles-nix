{ ... }: {
  flake.modules.nixos.hardware-intel-laptop = {
    boot.kernelParams = [
      "mem_sleep_default=deep"
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
    ];

    boot.blacklistedKernelModules = [ "psmouse" ];

    services.throttled.enable = true;
    services.thermald.enable = true;
  };
}
