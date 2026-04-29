{ pkgs, ... }:
{
  # Daily backup
  systemd.timers."backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 2:00:00";
      Unit = "backup.service";
    };
  };

  systemd.services."backup" = {
    path = [
      pkgs.borg
    ];
    script = ''
      set -eu

      # My Stuff
      ${pkgs.borg} create /mnt/Backup/home::$(date +%m-%d) /home/ben

      # All the services in /srv
      ${pkgs.borg} create /mnt/Backup/services::$(date +%m-%d) /srv
    '';
    serviceConfig = {
      EnvironmentFile = "/root/.secrets";
      Type = "oneshot";
    };
  };
}
