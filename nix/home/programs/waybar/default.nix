{ ... }:

let
  readConfig = file: (builtins.fromJSON (builtins.readFile file));
in
{
  programs.waybar = {
    enable = true;

    settings = [
      (readConfig ./config/config)
    ];
    style = ./config/style.css;
  };
}
