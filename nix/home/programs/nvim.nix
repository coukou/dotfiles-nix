{ inputs, system, ... }: {
  home.packages = [
    (inputs.my-nixvim.packages.${system}.default)
  ];
}
