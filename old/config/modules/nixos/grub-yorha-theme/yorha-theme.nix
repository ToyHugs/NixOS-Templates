# Toypass.nix
{ pkgs, ... }:

let
  yorha-theme = pkgs.stdenv.mkDerivation {
    name = "yorha-grub-theme";
    src = ./theme;
    installPhase = ''
      mkdir -p $out/share/grub/themes/yorha
      cp -r $src/* $out/share/grub/themes/yorha
    '';
  };
in
yorha-theme