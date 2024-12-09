# Toypass.nix
{ pkgs, ... }:

let
  toypass = pkgs.stdenv.mkDerivation {
    name = "toypass";
    propagatedBuildInputs = [( pkgs.python3.withPackages (
        pythonPackages: with pythonPackages; [ pyperclip ]
        ))];
    dontUnpack = true;
    installPhase = "install -Dm755 ${./toypass.py} $out/bin/toypass";
  };
in
toypass