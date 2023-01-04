# nix-overlay

A Nix overlay for my personal projects! Packaged for macOS, so some dependencies might be missing if building on Linux.

## Usage

 Add it as a input in `flake.nix`:

 ```nix
 {
   inputs.personal.url = "github:alaidriel/nix-overlay";
 }
 ```