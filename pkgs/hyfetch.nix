{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  python3,
}:
pkgs.python3.pkgs.buildPythonApplication {
  pname = "hyfetch";
  version = "1.4.11";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "alaidriel";
    repo = "hyfetch";
    rev = "76244624b68cca980a9f7032b1ef501dc141ee1e";
    hash = "sha256-nnZa0T1GJyabnzc0OosPBq5iamnN4yKeYrktOgSDKZk=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    typing-extensions
    setuptools
  ];

  # No test available
  doCheck = false;

  pythonImportsCheck = [
    "hyfetch"
  ];

  meta = with lib; {
    platforms = platforms.all;
  };
}
