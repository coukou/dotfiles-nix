{ inputs, ... }: {
  perSystem = { pkgs, system, ... }:
    let
      nvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit pkgs;
        module = { imports = [ ../_packages/nixvim/default.nix ]; };
        extraSpecialArgs = { inherit inputs system; };
      };
    in
    {
      packages.nvim = nvim;
      apps.nvim = { type = "app"; program = "${nvim}/bin/nvim"; };
    };
}
