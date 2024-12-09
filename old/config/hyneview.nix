# By Ciflire

{
  appimageTools,
  fetchurl,
  makeDesktopItem,
  lib,
}:
appimageTools.wrapType2 rec {
  name = "hyneview";
  version = "4.7.4";

  src = fetchurl {
    url = "http://matrix-repository.telecomnancy.univ-lorraine.fr/DIATEAM_Cyber_Range_hyneview_4.7.4.AppImage";
    hash = "sha256-WQ2/dmWMbfcTzmgPZuRGBmaLHeGm79GsRP9swbYu34s=";
  };
  # extraPkgs = pkgs: [ pkgs.libthai ];

  desktopItems = [
    (makeDesktopItem {
      name = "hyneview";
      exec = "hyneview";
      icon = "hyneview";
      desktopName = "Hyneview";
      comment = meta.description;
      categories = [ "Network" ];
    })
  ];
  meta = {
    description = "Cyberrange platform dedicated to TELECOM Nancy";
    mainProgram = "hyneview";
    maintainers = with lib.maintainers; [ ciflire ];
    platforms = lib.platforms.linux;
  };
}