{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.octoprint;

  stateDir = "${cfg.baseDir}/octoprint";
  restartTriggerFile = "${cfg.baseDir}/restart";

  baseConfig = {
    plugins.curalegacy.cura_engine = "${pkgs.curaengine_stable}/bin/CuraEngine";
    server.host = cfg.host;
    server.port = cfg.port;
    server.commands.serverRestartCommand = "touch ${restartTriggerFile}";
    webcam.ffmpeg = "${pkgs.ffmpeg.bin}/bin/ffmpeg";
  };

  fullConfig = recursiveUpdate cfg.extraConfig baseConfig;

  cfgUpdate = pkgs.writeText "octoprint-config.yaml" (builtins.toJSON fullConfig);

  pluginsEnv = package.python.withPackages (ps: [ps.octoprint] ++ (cfg.plugins ps));

  package = pkgs.octoprint;

in
{
  ##### interface

  options = {

    services.octoprint = {

      enable = mkEnableOption (lib.mdDoc "OctoPrint, web interface for 3D printers");

      host = mkOption {
        type = types.str;
        default = "0.0.0.0";
        description = lib.mdDoc ''
          Host to bind OctoPrint to.
        '';
      };

      port = mkOption {
        type = types.port;
        default = 5000;
        description = lib.mdDoc ''
          Port to bind OctoPrint to.
        '';
      };

      user = mkOption {
        type = types.str;
        default = "octoprint";
        description = lib.mdDoc "User for the daemon.";
      };

      group = mkOption {
        type = types.str;
        default = "octoprint";
        description = lib.mdDoc "Group for the daemon.";
      };

      baseDir = mkOption {
        type = types.path;
        default = "/var/lib/octoprint";
        description = lib.mdDoc "Base directory of the daemon.";
      };

      plugins = mkOption {
        type = types.functionTo (types.listOf types.package);
        default = plugins: [];
        defaultText = literalExpression "plugins: []";
        example = literalExpression "plugins: with plugins; [ themeify stlviewer ]";
        description = lib.mdDoc "Additional plugins to be used. Available plugins are passed through the plugins input.";
      };

      extraConfig = mkOption {
        type = types.attrs;
        default = {};
        description = lib.mdDoc "Extra options which are added to OctoPrint's YAML configuration file.";
      };

    };

  };

  ##### implementation

  config = mkIf cfg.enable {

    users.users = optionalAttrs (cfg.user == "octoprint") {
      octoprint = {
        group = cfg.group;
        uid = config.ids.uids.octoprint;
      };
    };

    users.groups = optionalAttrs (cfg.group == "octoprint") {
      octoprint.gid = config.ids.gids.octoprint;
    };

    systemd.tmpfiles.rules = [
      "d '${cfg.baseDir}' - ${cfg.user} ${cfg.group} - -"
      "d '${stateDir}' - ${cfg.user} ${cfg.group} - -"
    ];

    # Helper service to detect octoprint restart requests
    systemd.paths.octoprint-restart-files = {
      wantedBy = [ "octoprint.service" ];
      pathConfig = {
        Unit = "octoprint-restarter.service";
        PathChanged = [ restartTriggerFile ];
      };
    };

    # Helper service to restart the actual octoprint service
    systemd.services.octoprint-restarter = {
      serviceConfig.Type = "oneshot";
      script = "systemctl restart octoprint.service";
    };

    systemd.services.octoprint = {
      description = "OctoPrint, web interface for 3D printers";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = [ pluginsEnv ];

      preStart = ''
        if [ -e "${stateDir}/config.yaml" ]; then
          ${pkgs.yaml-merge}/bin/yaml-merge "${stateDir}/config.yaml" "${cfgUpdate}" > "${stateDir}/config.yaml.tmp"
          mv "${stateDir}/config.yaml.tmp" "${stateDir}/config.yaml"
        else
          cp "${cfgUpdate}" "${stateDir}/config.yaml"
          chmod 600 "${stateDir}/config.yaml"
        fi
      '';

      serviceConfig = {
        ExecStart = "${pluginsEnv}/bin/octoprint serve -b ${stateDir}";
        User = cfg.user;
        Group = cfg.group;
        SupplementaryGroups = [
          "dialout"
        ];
      };
    };

  };

}
