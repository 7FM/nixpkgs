{ lib, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "rpio";
  version = "0.10.0";

  src = fetchPypi {
    pname = "RPIO";
    inherit version;
    sha256 = "sha256-uJ913sneNUaBIJ6/rt/iK3wXiqzZGmBKe9bZICTkz34=";
  };

  # Tests disable because they do a platform check which requires running on a
  # Raspberry Pi
  #doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/metachris/RPIO";
    description = "RPIO is a GPIO toolbox for the Raspberry Pi.";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ _7FM ];
  };
}
