{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "athena";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "alaidriel";
    repo = pname;
    rev = "132e81981fdbffa4ed658277f1d88148a545331e";
    sha256 = "sha256-RUDIxSWH/yU8rp7Cie3f3/4b/jIWZs+UpZeQXWTFJeU=";
  };

  buildInputs =
    []
    ++ lib.optionals stdenv.isDarwin (
      with pkgs.darwin.apple_sdk; [
        frameworks.Security
        frameworks.CoreFoundation
      ]
    );

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  meta = with lib; {
    platforms = platforms.darwin;
  };
}
