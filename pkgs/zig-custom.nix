{ pkgs, lib, stdenv, ... }:

let
  arch = "x86_64";
  sha256 = "87f32ad9810e161b7691bf0b1968fd0a4289bd4757f87243468ed4c633d6da3f";
  version = "0.11.0-dev.1201+301a89849";
in
stdenv.mkDerivation {
  inherit version;

  pname = "zig";

  src = builtins.fetchurl {
    inherit sha256;
    url = "https://ziglang.org/builds/zig-macos-${arch}-${version}.tar.xz";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp zig $out/bin
    cp -r lib $out/lib
    cp -r doc $out/doc
  '';

  meta = {
    platforms = [ "${arch}-darwin" ];
  };
}
