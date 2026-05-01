{ pkgs, ... }:
{
  # TODO preferably package the whole bot with nix
  systemd.services.badminbot = {
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
}
