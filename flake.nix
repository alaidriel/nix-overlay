{
  description = "A Nix overlay for my personal projects";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system: {
        packages =
          let
            pkgs = import nixpkgs {
              inherit system;
            };
          in
          {
            etherea = pkgs.callPackage ./pkgs/etherea.nix { inherit pkgs; };
            athena = pkgs.callPackage ./pkgs/athena.nix { inherit pkgs; };
          };
      }) // {
      overlays.default = final: prev:
        let pkgs = prev; in {
          etherea = pkgs.callPackage ./pkgs/etherea.nix { inherit pkgs; };
          athena = pkgs.callPackage ./pkgs/athena.nix { inherit pkgs; };
        };
    };
}
