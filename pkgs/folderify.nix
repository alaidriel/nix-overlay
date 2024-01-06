{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "folderify";
  version = "3.0.13";

  src = fetchFromGitHub {
    owner = "alaidriel";
    repo = pname;
    rev = "ecba53e7997121470b245b3cd514e2a8697a992c";
    sha256 = "KgZr6vnKG5+tXHWlgThPDtu6ZesXUUPpeGz+AqNgT6c=";
  };

  buildInputs =
    []
    ++ lib.optionals stdenv.isDarwin (
      with pkgs.darwin.apple_sdk; [
        frameworks.ApplicationServices
        frameworks.CoreVideo
        frameworks.AppKit
      ]
    );

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  meta = with lib; {
    platforms = platforms.darwin;
  };
}
