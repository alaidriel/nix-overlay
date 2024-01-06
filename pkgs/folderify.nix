{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  makeWrapper,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "folderify";
  version = "3.0.13";

  src = fetchFromGitHub {
    owner = "lgarron";
    repo = pname;
    rev = "23c336a3cb798824b0e060757cc62bf748a16939";
    sha256 = "KgZr6vnKG5+tXHWlgThPDtu6ZesXUUPpeGz+AqNgT6c=";
  };

  nativeBuildInputs = [makeWrapper];

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

  postInstall = ''
    wrapProgram $out/bin/folderify \
      --prefix PATH : ${lib.makeBinPath (with pkgs; [imagemagick])}
  '';

  meta = with lib; {
    platforms = platforms.darwin;
  };
}
