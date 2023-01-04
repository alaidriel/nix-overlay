{
  description = "A Nix overlay for my personal projects";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
  };

  outputs = { self, nixpkgs, ... }: {
    overlays.default = final: prev:
      let pkgs = prev; in {
        etherea = pkgs.callPackage ./pkgs/etherea.nix { inherit pkgs; };
        athena = pkgs.callPackage ./pkgs/athena.nix { inherit pkgs; };
      };
  };
}
