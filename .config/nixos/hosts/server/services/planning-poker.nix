{ config, ... }:
{

  services = {
    anubis.instances."poker" = {
      enable = true;
      settings = {
        TARGET = "http://localhost:8000";
        BIND = "/run/anubis/anubis-poker/anubis.sock";
      };
    };

    nginx.virtualHosts."poker.bendeguz.xyz" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://unix:${config.services.anubis.instances.poker.settings.BIND}";
        extraConfig = ''
          proxy_set_header X-Real-IP $remote_addr;
        '';
      };
    };
  };

  systemd.services.planning-poker = {
    description = "planning-poker";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/srv/planning-poker/planning-poker";
      # EnvironmentFile = "/srv/badminbot/.env";
      WorkingDirectory = "/srv/planning-poker";
      Restart = "on-failure";
      # DynamicUser = true;
      User = "deploy";
    };
  };
}
