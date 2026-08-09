{ pkgs, ... }:
{
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
