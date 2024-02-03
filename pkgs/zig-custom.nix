{
  pkgs,
  lib,
  stdenv,
  ...
}: let
  arch = "aarch64";
  sha256 = "0lbwgac61wvb5hi7s3f8hc2lgqh9wha1bp199gramwaik6shnn27";
  version = "0.12.0-dev.2543+9eda6ccef";
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
