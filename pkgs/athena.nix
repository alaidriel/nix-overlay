{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "athena";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "alaidriel";
    repo = "athena";
    rev = "132e81981fdbffa4ed658277f1d88148a545331e";
    sha256 = "sha256-RUDIxSWH/yU8rp7Cie3f3/4b/jIWZs+UpZeQXWTFJeU=";
  };

  buildInputs = with pkgs.darwin.apple_sdk; with pkgs; [
    rustc
    cargo
    frameworks.Security
    frameworks.CoreFoundation
  ];

  buildPhase = ''
    cargo build --release
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./target/release/athena $out/bin
  '';
}
