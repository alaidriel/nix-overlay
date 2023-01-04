{ pkgs, ... }:

with pkgs;

stdenv.mkDerivation {
  pname = "athena";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "alaidriel";
    repo = "athena";
    rev = "132e81981fdbffa4ed658277f1d88148a545331e";
    sha256 = "sha256-RUDIxSWH/yU8rp7Cie3f3/4b/jIWZs+UpZeQXWTFJeU=";
  };

  buildInputs = [
    rustc
    cargo
  ] ++ lib.optionals stdenv.isDarwin (
    with pkgs.darwin.apple_sdk; [
      frameworks.Security
      frameworks.CoreFoundation
    ]
  );

  buildPhase = ''
    cargo build --release
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./target/release/athena $out/bin
  '';
}
