{ pkgs, lib, stdenv, ... }:

stdenv.mkDerivation {
  pname = "zig";
  version = "0.11.0-dev.1183+2b9478ce1";

  src = builtins.fetchurl {
    url = "https://ziglang.org/builds/zig-macos-x86_64-0.11.0-dev.1183+2b9478ce1.tar.xz";
    sha256 = "sha256:15ybn36i4c8ph1fwnzzyzm0hn8xwy6swa1xqbsha3sjlrb363rj8";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp zig $out/bin
    cp -r lib $out/lib
    cp -r doc $out/doc
  '';
}
