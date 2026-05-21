{ pkgs, ... }:
{
  systemd.services.badminbot = {
    description = "Badminbot";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/srv/badminbot/badminbot-v3";
      EnvironmentFile = "/srv/badminbot/.env";
      WorkingDirectory = "/srv/badminbot";
      Restart = "on-failure";
      # DynamicUser = true;
      User = "deploy";
    };
  };
}
