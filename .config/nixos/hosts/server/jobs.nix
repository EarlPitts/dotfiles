{ pkgs, ... }:
{

  # Backups
  services.borgbackup.jobs = {
    home = {
      paths = [ "/home/ben" ];
      repo = "/mnt/Backup/home";
      startAt = "*-*-* 2:00:00";
      encryption = {
        mode = "repokey";
        passCommand = "cat /root/.borg-pass";
        # passCommand = "${pkgs.pass}/bin/pass Misc/ServerBackup"; TODO
      };
      prune.keep = {
        daily = 7;
        weekly = 4;
      };
    };
    services = {
      paths = [ "/srv" ];
      repo = "/mnt/Backup/services";
      startAt = "*-*-* 2:00:00";
      encryption = {
        mode = "repokey";
        passCommand = "cat /root/.borg-pass";
        # passCommand = "${pkgs.pass}/bin/pass Misc/ServerBackup"; TODO
      };
      prune.keep = {
        daily = 7;
        weekly = 4;
      };
    };
  };

  # TODO this can also be done with the nixos smart service
  # SMART scan
  systemd.timers."smart" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "Sun 00:00:00";
      Unit = "smart.service";
    };
  };

  systemd.services."smart" = {
    script = ''
      ${pkgs.smartmontools}/bin/smartctl -t long /dev/sda
      ${pkgs.smartmontools}/bin/smartctl -t long /dev/sdb
      #smartctl -t long /dev/sdc
      # Prevent external hard-drive from sleeping
      #while true; do
      #   dd if=/dev/sdc iflag=direct count=1 of=/dev/null
      #   sleep 60
      #done
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };

}
