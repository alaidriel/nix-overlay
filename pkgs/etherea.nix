{ pkgs, lib, stdenv, fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "etherea";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "alaidriel";
    repo = pname;
    rev = "b1baa9f44632f2ac907f26e099898bd6ec4e0b71";
    sha256 = "sha256-jLS7PmMYxTXa9IN7V4VpE6Z0+fLyhpHN3AYuJZCSMjo=";
  };

  buildInputs = [ ] ++ lib.optionals stdenv.isDarwin (
    with pkgs.darwin.apple_sdk; [
      pkgs.darwin.libobjc
      frameworks.ApplicationServices
      frameworks.CoreVideo
      frameworks.AppKit
      frameworks.QuartzCore
      frameworks.Foundation
      frameworks.CoreGraphics
      frameworks.CoreFoundation
      frameworks.Metal
    ]
  );

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  meta = with lib; {
    platforms = platforms.darwin;
  };
}
