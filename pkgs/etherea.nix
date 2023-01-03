{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "etherea";
  version = "0.2.3";

  src = pkgs.fetchFromGitHub {
    owner = "alaidriel";
    repo = "etherea";
    rev = "5f0df4094055a783b35ffcbd514eff4dd1407155";
    sha256 = "sha256-Ydqfl0SkfhwjQKIsM22MNgY14L9jlJkZzXJyjX4rVGg=";
  };

  buildInputs = with pkgs.darwin.apple_sdk; with pkgs; [
    rustc
    cargo
    darwin.libobjc
    frameworks.ApplicationServices
    frameworks.CoreVideo
    frameworks.AppKit
    frameworks.QuartzCore
    frameworks.Foundation
    frameworks.CoreGraphics
    frameworks.CoreFoundation
    frameworks.Metal
  ];

  buildPhase = ''
    cargo build --release
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./target/release/etherea $out/bin
  '';
}
