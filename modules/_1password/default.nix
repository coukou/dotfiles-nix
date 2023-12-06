
{ lib, config, pkgs, ... }:

let 
  cfg = config.modules._1password;
in
{
  options.modules._1password = { enable = lib.mkEnableOption "_1password"; };
  config = lib.mkIf cfg.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "coukou" ];
    };
  };
}
