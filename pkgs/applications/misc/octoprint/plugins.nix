{ pkgs }:

with pkgs;

self: super:
let
  buildPlugin = args: self.buildPythonPackage (args // {
    pname = "OctoPrintPlugin-${args.pname}";
    inherit (args) version;
    propagatedBuildInputs = (args.propagatedBuildInputs or [ ]) ++ [ super.octoprint ];
    # none of the following have tests
    doCheck = false;
  });
in
{
  inherit buildPlugin;

  m86motorsoff = buildPlugin rec {
    pname = "M84MotorsOff";
    version = "0.1.0";

    src = fetchFromGitHub {
      owner = "ntoff";
      repo = "Octoprint-M84MotOff";
      rev = "v${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdq7";
    };

    meta = with lib; {
      description = "Changes the \"Motors off\" button in octoprint's control tab to issue an M84 command to allow compatibility with Repetier firmware Resources";
      homepage = "https://github.com/ntoff/OctoPrint-M84MotOff";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ stunkymonkey ];
    };
  };

  abl-expert = buildPlugin rec {
    pname = "ABL_Expert";
    version = "0.6";

    src = fetchgit {
      url = "https://framagit.org/razer/Octoprint_ABL_Expert/";
      rev = version;
      sha256 = "0ij3rvdwya1sbymwm5swlh2j4jagb6fal945g88zrzh5xf26hzjh";
    };

    meta = with lib; {
      description = "Marlin auto bed leveling control, mesh correction, and z probe handling";
      homepage = "https://framagit.org/razer/Octoprint_ABL_Expert/";
      license = licenses.agpl3;
      maintainers = with maintainers; [ WhittlesJr ];
    };
  };

  autoscroll = buildPlugin rec {
    pname = "Autoscroll";
    version = "0.0.3";

    src = fetchFromGitHub {
      owner = "MoonshineSG";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Turn on/off terminal autoscroll when scrolling up/down";
      homepage = "https://github.com/MoonshineSG/OctoPrint-Autoscroll";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  bedlevelingwizard = buildPlugin rec {
    pname = "BedLevelingWizard";
    version = "0.2.4";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Plugin to aid in the process of manually leveling your bed";
      homepage = "https://github.com/jneilliii/OctoPrint-BedLevelingWizard";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  bedlevelvisualizer = buildPlugin rec {
    pname = "BedLevelVisualizer";
    version = "1.1.0";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "sha256-SKrhtTGyDuvbDmUCXSx83Y+C83ZzVHA78TwMYwE6tcc=";
    };

    propagatedBuildInputs = with super; [ numpy ];

    meta = with lib; {
      description = "Displays 3D mesh of bed topography report";
      homepage = "https://github.com/jneilliii/OctoPrint-BedLevelVisualizer";
      license = licenses.agpl3;
      maintainers = with maintainers; [ lovesegfault ];
    };
  };

  bltouch = buildPlugin rec {
    pname = "BLTouch";
    version = "0.3.4";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Simple plugin to add BLTouch controls to the Control tab";
      homepage = "https://github.com/jneilliii/OctoPrint-BLTouch";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  costestimation = buildPlugin rec {
    pname = "CostEstimation";
    version = "3.4.0";

    src = fetchFromGitHub {
      owner = "OllisGit";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "sha256-04OPa/RpM8WehUmOp195ocsAjAvKdVY7iD5ybzQO7Dg=";
    };

    meta = with lib; {
      description = "Plugin to display the estimated print cost for the loaded model.";
      homepage = "https://github.com/OllisGit/OctoPrint-CostEstimation";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ stunkymonkey ];
    };
  };

  curaenginelegacy = buildPlugin rec {
    pname = "CuraEngineLegacy";
    version = "1.1.2";

    src = fetchFromGitHub {
      owner = "OctoPrint";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "sha256-54siSmzgPlnCRpkpZhXU9theNQ3hqL3j+Ip4Ie2w2vA=";
    };

    meta = with lib; {
      description = "Plugin for slicing via Cura Legacy from within OctoPrint";
      homepage = "https://github.com/OctoPrint/OctoPrint-CuraEngineLegacy";
      license = licenses.agpl3;
      maintainers = with maintainers; [ gebner ];
    };
  };

  displayprogress = buildPlugin rec {
    pname = "DisplayProgress";
    version = "0.1.3";

    src = fetchFromGitHub {
      owner = "OctoPrint";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "080prvfwggl4vkzyi369vxh1n8231hrl8a44f399laqah3dn5qw4";
    };

    meta = with lib; {
      description = "Displays the job progress on the printer's display";
      homepage = "https://github.com/OctoPrint/OctoPrint-DisplayProgress";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ stunkymonkey ];
    };
  };

  displaylayerprogress = buildPlugin rec {
    pname = "OctoPrint-DisplayLayerProgress";
    version = "1.26.0";

    src = fetchFromGitHub {
      owner = "OllisGit";
      repo = pname;
      rev = version;
      sha256 = "sha256-hhHc2SPixZCPJzCP8enMMWNYaYbNZAU0lNSx1B0d++4=";
    };

    meta = with lib; {
      description = "OctoPrint-Plugin that sends the current progress of a print via M117 command";
      homepage = "https://github.com/OllisGit/OctoPrint-DisplayLayerProgress";
      license = licenses.agpl3;
      maintainers = with maintainers; [ j0hax ];
    };
  };

  emergencystopsimplified = buildPlugin rec {
    pname = "Emergency_stop_simplified";
    version = "0.1.1";

    src = fetchFromGitHub {
      owner = "Mechazawa";
      repo = "${pname}";
      rev = "${version}";
      sha256 = "sha256-41pxUu6OHp0im/2n1Z9JuBN3zzoGlY2qqFUx9/srfAM=";
    };

    propagatedBuildInputs = with super; [ rpi-gpio ];

    meta = with lib; {
      description = "This plugin reacts to a switch or button, if triggered (switch open) it issues M112 command to printer";
      homepage = "https://github.com/Mechazawa/Emergency_stop_simplified";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  enclosure = buildPlugin rec {
    pname = "Enclosure";
    version = "4.13.2";

    src = fetchFromGitHub {
      owner = "vitormhenrique";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Control printer environment (Temperature control / Lights / Fans and Filament Sensor) using Raspberry Pi GPIO";
      homepage = "https://github.com/vitormhenrique/OctoPrint-Enclosure";
      license = licenses.gpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  ender3v2tempfix = buildPlugin rec {
    pname = "OctoPrintPlugin-ender3v2tempfix";
    version = "unstable-2021-04-27";

    src = fetchFromGitHub {
      owner = "SimplyPrint";
      repo = "OctoPrint-Creality2xTemperatureReportingFix";
      rev = "2c4183b6a0242a24ebf646d7ac717cd7a2db2bcf";
      sha256 = "03bc2zbffw4ksk8if90kxhs3179nbhb4xikp4f0adm3lrnvxkd3s";
    };

    meta = with lib; {
      description = "Fixes the double temperature reporting from the Creality Ender-3 v2 printer";
      homepage = "https://github.com/SimplyPrint/OctoPrint-Creality2xTemperatureReportingFix";
      license = licenses.mit;
      maintainers = with maintainers; [ illustris ];
    };
  };

  excluderegion = buildPlugin rec {
    pname = "ExcludeRegionPlugin";
    version = "0.3.0";

    src = fetchFromGitHub {
      owner = "bradcfisher";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Adds the ability to prevent printing within rectangular or circular regions of the currently active gcode file";
      homepage = "https://github.com/bradcfisher/OctoPrint-ExcludeRegionPlugin";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  floatingnavbar = buildPlugin rec {
    pname = "FloatingNavbar";
    version = "0.3.7";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Make the navbar float/stick to the top of the page";
      homepage = "https://github.com/jneilliii/OctoPrint-FloatingNavbar";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  gcodeeditor = buildPlugin rec {
    pname = "GcodeEditor";
    version = "0.2.12";

    src = fetchFromGitHub {
      owner = "ieatacid";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "sha256-1Sk2ri3DKW8q8VJ/scFjpRsz65Pwt8OEURP1k70aydE=";
    };

    meta = with lib; {
      description = "Edit gcode on OctoPrint";
      homepage = "https://github.com/ieatacid/OctoPrint-GcodeEditor";
      license = licenses.agpl3;
      maintainers = with maintainers; [ WhittlesJr ];
    };
  };

  heatertimeout = buildPlugin rec {
    pname = "HeaterTimeout";
    version = "0.0.4";

    src = fetchFromGitHub {
      owner = "Andy-ch";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "sha256-F3QZ/VhjO7eo5xGxVuOPwbrm24+zor4CUu7+JmXzDXw=";
    };

    meta = with lib; {
      description = "Automatically shut off heaters if no print has been started";
      homepage = "https://github.com/Andy-ch/OctoPrint-HeaterTimeout";
      license = licenses.asl20;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  marlingcodedocumentation = buildPlugin rec {
    pname = "MarlinGcodeDocumentation";
    version = "0.13.0";

    src = fetchFromGitHub {
      owner = "costas-basdekis";
      repo = pname;
      rev = "v${version}";
      sha256 = "sha256-3ay6iCxZk8QkFM/2Y14VTpPoxr6NXq14BFSHofn3q7I=";
    };

    meta = with lib; {
      description = "Displays GCode documentation for Marlin in the Octoprint terminal command line";
      homepage = "https://github.com/costas-basdekis/MarlinGcodeDocumentation";
      license = licenses.agpl3;
      maintainers = with maintainers; [ lovesegfault ];
    };
  };

  mqtt = buildPlugin rec {
    pname = "MQTT";
    version = "0.8.10";

    src = fetchFromGitHub {
      owner = "OctoPrint";
      repo = "OctoPrint-MQTT";
      rev = version;
      sha256 = "sha256-nvEUvN/SdUE1tQkLbxMkZ8xxeUIZiNNirIfWLeH1Kfg=";
    };

    propagatedBuildInputs = with super; [ paho-mqtt ];

    meta = with lib; {
      description = "Publish printer status MQTT";
      homepage = "https://github.com/OctoPrint/OctoPrint-MQTT";
      license = licenses.agpl3;
      maintainers = with maintainers; [ peterhoeg ];
    };
  };

  multilineterminal = buildPlugin rec {
    pname = "MultiLineTerminal";
    version = "0.1.5";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Makes the terminal input a multi line text area";
      homepage = "https://github.com/jneilliii/OctoPrint-MultiLineTerminal";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  multipleupload = buildPlugin rec {
    pname = "MultipleUpload";
    version = "1.1.0";

    src = fetchFromGitHub {
      owner = "eyal0";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Allow uploading multiple files at once";
      homepage = "https://github.com/eyal0/OctoPrint-MultipleUpload";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  navbartemp = buildPlugin rec {
    pname = "NavbarTemp";
    version = "0.14";

    src = fetchFromGitHub {
      owner = "imrahil";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Display temperatures on navbar";
      homepage = "https://github.com/imrahil/OctoPrint-NavbarTemp";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  printtimegenius = buildPlugin rec {
    pname = "PrintTimeGenius";
    version = "2.2.8";

    src = fetchFromGitHub {
      owner = "eyal0";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "sha256-Bbpm7y4flzEbUb6Sgkp6hIIHs455A0IsbmzvZwlkbh0=";
    };

    propagatedBuildInputs = with super; [
      psutil
      sarge
    ];

    preConfigure = ''
      # PrintTimeGenius ships with marlin-calc binaries for multiple architectures
      rm */analyzers/marlin-calc*
      sed 's@"{}.{}".format(binary_base_name, machine)@"${pkgs.marlin-calc}/bin/marlin-calc"@' -i */analyzers/analyze_progress.py
    '';

    meta = with lib; {
      description = "Better print time estimation for OctoPrint";
      homepage = "https://github.com/eyal0/OctoPrint-PrintTimeGenius";
      license = licenses.agpl3;
      maintainers = with maintainers; [ gebner ];
    };
  };

  psucontrol = buildPlugin rec {
    pname = "PSUControl";
    version = "1.0.6";

    src = fetchFromGitHub {
      owner = "kantlivelong";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "sha256-S+lPm85+ZEO/3BXYsrxE4FU29EGWzWrSw3y1DLdByrM=";
    };

    propagatedBuildInputs = with super; [
      python-periphery
    ];

    preConfigure = ''
      # optional; RPi.GPIO is broken on vanilla kernels
      sed /RPi.GPIO/d -i requirements.txt
    '';

    meta = with lib; {
      description = "OctoPrint plugin to control ATX/AUX power supply";
      homepage = "https://github.com/kantlivelong/OctoPrint-PSUControl";
      license = licenses.agpl3;
      maintainers = with maintainers; [ gebner ];
    };
  };

  resource_monitor = buildPlugin rec {
    pname = "Resource-Monitor";
    version = "0.3.6";

    src = fetchFromGitHub {
      owner = "Renaud11232";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "A plugin to view the current CPU, RAM, disk and network usage on your system";
      homepage = "https://github.com/Renaud11232/OctoPrint-Resource-Monitor";
      license = licenses.mit;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  simpleemergencystop = buildPlugin rec {
    pname = "SimpleEmergencyStop";
    version = "1.0.5";

    src = fetchFromGitHub {
      owner = "Sebclem";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "sha256-MbP3cKa9FPElQ/M8ykYh9kVXl8hNvmGiCHDvjgWvm9k=";
    };

    meta = with lib; {
      description = "A simple plugin that add an emergency stop buton on NavBar of OctoPrint";
      homepage = "https://github.com/Sebclem/OctoPrint-SimpleEmergencyStop";
      license = licenses.agpl3;
      maintainers = with maintainers; [ WhittlesJr ];
    };
  };

  stlviewer = buildPlugin rec {
    pname = "STLViewer";
    version = "0.4.2";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "OctoPrint-STLViewer";
      rev = version;
      sha256 = "0mkvh44fn2ch4z2avsdjwi1rp353ylmk9j5fln4x7rx8ph8y7g2b";
    };

    meta = with lib; {
      description = "A simple stl viewer tab for OctoPrint";
      homepage = "https://github.com/jneilliii/Octoprint-STLViewer";
      license = licenses.agpl3;
      maintainers = with maintainers; [ abbradar ];
    };
  };

  taborder = buildPlugin rec {
    pname = "OctoPrint-TabOrder";
    version = "0.5.12";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Simple plugin to allow the ordering of tabs within OctoPrint";
      homepage = "https://github.com/jneilliii/OctoPrint-TabOrder";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  telegram = buildPlugin rec {
    pname = "Telegram";
    version = "1.6.5";

    src = fetchFromGitHub {
      owner = "fabianonline";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "sha256-SckJCbPNCflgGYLHFiXy0juCtpvo8YS1BQsFpc1f5rg=";
    };

    propagatedBuildInputs = with super; [ pillow ];

    meta = with lib; {
      description = "Plugin to send status messages and receive commands via Telegram messenger.";
      homepage = "https://github.com/fabianonline/OctoPrint-Telegram";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ stunkymonkey ];
    };
  };

  themeify = buildPlugin rec {
    pname = "Themeify";
    version = "1.2.2";

    src = fetchFromGitHub {
      owner = "Birkbjo";
      repo = "Octoprint-${pname}";
      rev = "v${version}";
      sha256 = "0j1qs6kyh947npdy7pqda25fjkqinpas3sy0qyscqlxi558lhvx2";
    };

    meta = with lib; {
      description = "Beautiful themes for OctoPrint";
      homepage = "https://github.com/birkbjo/OctoPrint-Themeify";
      license = licenses.agpl3;
      maintainers = with maintainers; [ lovesegfault ];
    };
  };

  titlestatus = buildPlugin rec {
    pname = "TitleStatus";
    version = "0.0.5";

    src = fetchFromGitHub {
      owner = "MoonshineSG";
      repo = "OctoPrint-TitleStatus";
      rev = version;
      sha256 = "10nxjrixg0i6n6x8ghc1ndshm25c97bvkcis5j9kmlkkzs36i2c6";
    };

    meta = with lib; {
      description = "Show printers status in window title";
      homepage = "https://github.com/MoonshineSG/OctoPrint-TitleStatus";
      license = licenses.agpl3;
      maintainers = with maintainers; [ abbradar ];
    };
  };

  touchui = buildPlugin rec {
    pname = "TouchUI";
    version = "0.3.18";

    src = fetchFromGitHub {
      owner = "BillyBlaze";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "sha256-PNDCjY7FhfnwK7Nd86el9ZQ00G4uMANH2Sk080iMYXw=";
    };

    meta = with lib; {
      description = "Touch friendly interface for a small TFT module or phone for OctoPrint";
      homepage = "https://github.com/BillyBlaze/OctoPrint-TouchUI";
      license = licenses.agpl3;
      maintainers = with maintainers; [ gebner ];
    };
  };

  uploadanything = buildPlugin rec {
    pname = "UploadAnything";
    version = "1.0.1";

    src = fetchFromGitHub {
      owner = "rlogiacco";
      repo = pname;
      rev = "560d230352e94fbf37c57476a60978713321643e";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Allows custom file types to be uploaded via the web interface";
      homepage = "https://github.com/rlogiacco/UploadAnything";
      license = licenses.asl20;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  webcamtab = buildPlugin rec {
    pname = "WebcamTab";
    version = "0.3.0";

    src = fetchFromGitHub {
      owner = "gruvin";
      repo = "OctoPrint-${pname}";
      rev = "${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdqs";
    };

    meta = with lib; {
      description = "Moves the webcam stream from Control tab to its own Webcam tab";
      homepage = "https://github.com/gruvin/OctoPrint-WebcamTab";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ _7FM ];
    };
  };

  octoklipper = buildPlugin rec {
    pname = "OctoKlipper";
    version = "0.3.8.3";

    src = fetchFromGitHub {
      owner = "AliceGrey";
      repo = "OctoprintKlipperPlugin";
      rev = version;
      sha256 = "sha256-6r5jJDSR0DxlDQ/XWmQgYUgeL1otNNBnwurX7bbcThg=";
    };

    meta = with lib; {
      description = "A plugin for a better integration of Klipper into OctoPrint";
      homepage = "https://github.com/AliceGrey/OctoprintKlipperPlugin";
      license = licenses.agpl3;
      maintainers = with maintainers; [ lovesegfault ];
    };
  };

  octolapse = buildPlugin rec {
    pname = "Octolapse";
    version = "0.4.1";

    src = fetchFromGitHub {
      owner = "FormerLurker";
      repo = pname;
      rev = "v${version}";
      sha256 = "13q20g7brabplc198jh67lk65rn140r8217iak9b2jy3in8fggv4";
    };

    # Test fails due to code executed on import, see #136513
    #pythonImportsCheck = [ "octoprint_octolapse" ];

    propagatedBuildInputs = with super; [ awesome-slugify setuptools pillow sarge six psutil file-read-backwards ];

    meta = with lib; {
      description = "Stabilized timelapses for Octoprint";
      homepage = "https://github.com/FormerLurker/OctoLapse";
      license = licenses.agpl3Plus;
      maintainers = with maintainers; [ illustris j0hax ];
    };
  };

  octoprint-dashboard = buildPlugin rec {
    pname = "OctoPrint-Dashboard";
    version = "1.18.3";

    src = fetchFromGitHub {
      owner = "StefanCohen";
      repo = pname;
      rev = version;
      sha256 = "sha256-hLHT3Uze/6PlOCEICVZ2ieFTyXgcqCvgHOlIIEquujg=";
    };

    meta = with lib; {
      description = "A dashboard for Octoprint";
      homepage = "https://github.com/StefanCohen/OctoPrint-Dashboard";
      license = licenses.agpl3;
      maintainers = with maintainers; [ j0hax ];
    };
  };
}
