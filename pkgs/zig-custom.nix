{
  pkgs,
  lib,
  stdenv,
  ...
}: let
  arch = "aarch64_darwin";
  sha256 = "14wi1il7rirl2097m2sywslnkn1sysx2gfj69zs6wk1s4n1jjn8f";
  version = "0.11.0-dev.1580+a5b34a61a";
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
      platforms = ["${arch}-darwin"];
    };
  }
