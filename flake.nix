{
  description = "A Nix overlay for my personal projects, packaged for use on macOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
  };

  outputs = { self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-darwin";
      };
    in
    {
      overlay = final: prev: {
        etherea = pkgs.callPackage ./pkgs/etherea.nix { inherit pkgs; };
      };
    };
}
