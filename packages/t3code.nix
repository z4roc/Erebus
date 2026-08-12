{
  lib,
  appimageTools,
  fetchurl,
  makeWrapper,
}:

let
  pname = "t3code";
  version = "0.0.33";

  src = fetchurl {
    url = "https://github.com/pingdotgg/t3code/releases/download/v${version}/T3-Code-${version}-x86_64.AppImage";
    hash = "sha256-QVyGSPQ8PSLVcvJ/LFD9yMMQ6n/N6VN7kD4eLxyHdaE=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  nativeBuildInputs = [ makeWrapper ];

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/t3code.desktop \
      $out/share/applications/t3code.desktop
    cp --recursive ${appimageContents}/usr/share/icons $out/share/

    substituteInPlace $out/share/applications/t3code.desktop \
      --replace-fail 'Exec=AppRun --no-sandbox %U' 'Exec=t3code %U'

    wrapProgram "$out/bin/t3code" \
      --set CHROME_DESKTOP t3code.desktop \
      --prefix XDG_DATA_DIRS : "$out/share"
  '';

  meta = {
    description = "Minimal web GUI for coding agents";
    homepage = "https://t3.codes";
    changelog = "https://github.com/pingdotgg/t3code/releases/tag/v${version}";
    downloadPage = "https://github.com/pingdotgg/t3code/releases";
    license = lib.licenses.mit;
    mainProgram = "t3code";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
