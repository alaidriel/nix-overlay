{
  description = "A collection of Nix packages for my personal use";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }: let
    genPkgs = pkgs:
      with pkgs;
        lib.genAttrs
        (builtins.map (x: lib.removeSuffix ".nix" x)
          (builtins.map
            (x: lib.removePrefix (toString ./pkgs + "/") (toString x))
            (lib.filesystem.listFilesRecursive ./pkgs)))
        (name: pkgs.callPackage ./pkgs/${name}.nix {inherit pkgs;});
  in
    flake-utils.lib.eachDefaultSystem
    (system: {
      packages = let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
        genPkgs pkgs;
    })
    // {
      overlays.default = final: prev: genPkgs prev;
    };
}
