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
    script = ''
      set -eu

      # My Stuff
      ${pkgs.borgbackup}/bin/borg create /mnt/Backup/home::$(date +%m-%d) /home/ben

      # All the services in /srv
      ${pkgs.borgbackup}/bin/borg create /mnt/Backup/services::$(date +%m-%d) /srv
    '';
    serviceConfig = {
      EnvironmentFile = "/root/.secrets";
      Type = "oneshot";
    };
  };

  # Weekly backup pruning
  systemd.timers."prune_backups" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "Sun 3:00:00";
      Unit = "prune_backups.service";
    };
  };

  systemd.services."prune_backups" = {
    script = ''
      set -eu

      ${pkgs.borgbackup}/bin/borg prune --keep-daily=7 --keep-weekly=4 /mnt/Backup/home
      ${pkgs.borgbackup}/bin/borg prune --keep-daily=7 --keep-weekly=4 /mnt/Backup/services
    '';
    serviceConfig = {
      EnvironmentFile = "/root/.secrets";
      Type = "oneshot";
    };
  };

}
