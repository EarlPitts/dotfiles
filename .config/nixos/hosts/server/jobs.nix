{ pkgs, ... }:
{
  # Backups
  services.borgbackup.jobs = {
    home = {
      paths = [ "/home/ben" ];
      repo = "/mnt/Backup/home";
      startAt = "*-*-* 2:00:00";
      user = "ben";
      encryption = {
        mode = "repokey";
        passCommand = "${pkgs.pass}/bin/pass Misc/ServerBackup";
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
}
