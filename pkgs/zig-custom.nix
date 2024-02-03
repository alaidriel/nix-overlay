{
  stdenv,
  lib,
  ...
}: let
  arch =
    if stdenv.isAarch64
    then "aarch64"
    else "x86_64";
  sha256 =
    if stdenv.isAarch64
    then "0lbwgac61wvb5hi7s3f8hc2lgqh9wha1bp199gramwaik6shnn27"
    else "5fb672a68f9461d7e1a815fb530ff4c4705989cbccf12d9b8b25a719dba7a385";
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
      platforms = lib.platforms.darwin;
    };
  }
