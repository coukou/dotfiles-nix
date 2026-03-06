{ inputs, system, ... }:
final: prev: {
  neovim = inputs.nixvim.packages.${system}.default;
}
