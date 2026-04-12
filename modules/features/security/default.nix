{ self, lib, ... }: {
  imports = [ ./_proton-pass.nix ];

  flake.modules.homeManager.security = { ... }: {
    imports = with self.modules.homeManager; [ security-proton-pass ];

    options.myConfig.protonPassVault = lib.mkOption {
      type = lib.types.str;
      description = "Proton Pass vault name used for the SSH agent";
    };
  };
}
