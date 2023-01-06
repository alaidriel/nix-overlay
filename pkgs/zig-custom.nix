{ pkgs, lib, stdenv, ... }:

let
  platform =
    let
      os =
        if stdenv.isLinux
        then "linux"
        else "macos";
      arch =
        if stdenv.isx86_64
        then "x86_64"
        else "aarch64";
    in
    "${os}-${arch}";
  sha256 = {
    macos-aarch64 = "0a16ff888bbf11ac7752847c100270be5e9c19927b539a92ba33e45004308ffe";
    macos-x86_64 = "87f32ad9810e161b7691bf0b1968fd0a4289bd4757f87243468ed4c633d6da3f";
  };
  version = "0.11.0-dev.1201+301a89849";
in
stdenv.mkDerivation {
  inherit version;

  pname = "zig";

  src = builtins.fetchurl {
    url = "https://ziglang.org/builds/zig-${platform}-${version}.tar.xz";
    sha256 = "sha256:${sha256.${platform}}";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp zig $out/bin
    cp -r lib $out/lib
    cp -r doc $out/doc
  '';

  meta = with lib; {
    platforms = platforms.darwin;
  };
}
