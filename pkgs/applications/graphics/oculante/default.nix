{ lib
, rustPlatform
, fetchFromGitHub
, cmake
, pkg-config
, openssl
, fontconfig
, nasm
, libX11
, libXcursor
, libXrandr
, libXi
, libGL
, libxkbcommon
, wayland
, stdenv
, gtk3
, darwin
, perl
, wrapGAppsHook
}:

rustPlatform.buildRustPackage rec {
  pname = "oculante";
  version = "0.8.8";

  src = fetchFromGitHub {
    owner = "woelper";
    repo = "oculante";
    rev = version;
    hash = "sha256-LfMun9eG/76wqm2SADYIjWXOHbCl5yikkdK2FoavSWY=";
  };

  cargoHash = "sha256-UALmfUD0+n4d/oYDgeX5mStOYw7QRftfCIE3AKezrQQ=";

  nativeBuildInputs = [
    cmake
    pkg-config
    nasm
    perl
    wrapGAppsHook
  ];

  checkFlagsArray = [ "--skip=tests::net" ]; # requires network access

  buildInputs = [
    openssl
    fontconfig
  ] ++ lib.optionals stdenv.isLinux [
    libGL
    libX11
    libXcursor
    libXi
    libXrandr
    gtk3

    libxkbcommon
    wayland
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.libobjc
  ];

  checkFlags = [
    "--skip=bench"
  ];

  postInstall = ''
    install -Dm444 $src/res/oculante.png -t $out/share/icons/hicolor/128x128/apps/
    install -Dm444 $src/res/oculante.desktop -t $out/share/applications
    wrapProgram $out/bin/oculante \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [libGL]}
  '';

  meta = with lib; {
    broken = stdenv.isDarwin;
    description = "A minimalistic crossplatform image viewer written in Rust";
    homepage = "https://github.com/woelper/oculante";
    changelog = "https://github.com/woelper/oculante/blob/${version}/CHANGELOG.md";
    license = licenses.mit;
    mainProgram = "oculante";
    maintainers = with maintainers; [ dit7ya figsoda ];
  };
}
