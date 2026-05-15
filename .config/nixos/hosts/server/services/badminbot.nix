{ pkgs, ... }:
{
  systemd.services.badminbotV2 = {
    description = "Badminbot";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/home/ben/Projects/badminbot-v2/venv/bin/python /home/ben/Projects/badminbot-v2/bot.py";
      EnvironmentFile = "/home/ben/Projects/badminbot-v2/.env";
      Restart = "on-failure";
      WorkingDirectory = "/home/ben/Projects/badminbot-v2";
      User = "ben";
    };
  };

  systemd.services.badminbotV3 = {
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
      User = "ben";
    };
  };
}
