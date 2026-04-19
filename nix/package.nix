{
  lib,
  flutter,
  copyDesktopItems,
  makeDesktopItem,
}:

flutter.buildFlutterApplication {
  pname = "chameleonultragui";
  version = "1.3.0";

  src = builtins.path {
    path = ./..;
    name = "source";
  };

  sourceRoot = "source/chameleonultragui";

  pubspecLock = lib.importJSON ./pubspec.lock.json;

  gitHashes = {
    file_saver = "sha256-3T4UVDkhjTmLakQqJ0/WCP9NOQlONHAzeK+y5gY7qa8=";
    flutter_libserialport = "sha256-Ksj5U94kCoe5FQ85m4Ui0t+Z4ME94E6TcDq45Xms0dE=";
    usb_serial = "sha256-sqGd5ECWVkqsW5ZGlnCV1veHsp0p7inBX2240Xe6NiU=";
  };

  postPatch = ''
    substituteInPlace linux/CMakeLists.txt \
      --replace-fail "-Wall -Werror" "-Wall"
  '';

  nativeBuildInputs = [ copyDesktopItems ];

  desktopItems = [
    (makeDesktopItem {
      name = "chameleonultragui";
      exec = "chameleonultragui %u";
      icon = "chameleonultragui";
      desktopName = "Chameleon Ultra GUI";
      genericName = "Chameleon Ultra GUI";
      comment = "GUI app for Chameleon Ultra and Lite";
      categories = [ "Utility" ];
      keywords = [
        "Flutter"
        "Chameleon"
        "ChameleonUltra"
        "ChameleonLite"
        "NFC"
      ];
    })
  ];

  postInstall = ''
    install -Dm644 assets/logo.png $out/share/pixmaps/chameleonultragui.png
    install -Dm644 ${./70-chameleon-ultra.rules} $out/lib/udev/rules.d/70-chameleon-ultra.rules
  '';

  meta = with lib; {
    description = "A cross platform GUI for the Chameleon Ultra written in Flutter";
    homepage = "https://github.com/GameTec-live/ChameleonUltraGUI";
    license = licenses.gpl3Only;
    maintainers = [ ];
    mainProgram = "chameleonultragui";
    platforms = platforms.linux;
  };
}
