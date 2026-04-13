{ inputs, ... }: {
  perSystem = { pkgs, system, ... }:
    let
      nvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit pkgs;
        module = {
          imports = [ (inputs.import-tree ../_packages/nixvim) ];
          # imports = [
          #   ../_packages/nixvim/_default.nix
          # ];
        };
        extraSpecialArgs = { inherit inputs system; };
      };
    in
    {
      packages.nvim = nvim;
      apps.nvim = { type = "app"; program = "${nvim}/bin/nvim"; };
    };
}
