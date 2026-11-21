{ lib, pkgs, ... }:
{
  # Mail sync
  services.mbsync = {
    enable = true;
    frequency = "*:0/5";
    verbose = false;
  };
  systemd.user.services.mbsync.Service = {
    Environment = "PATH=${lib.makeBinPath [ pkgs.gnupg ]}";
  };

  # RSS sync
  systemd.user.services.rss = {
    Unit.Description = "Reload newsboat feeds";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.newsboat}/bin/newsboat -x reload";
    };
  };
  systemd.user.timers.rss = {
    Unit.Description = "Reload newsboat feeds hourly";
    Timer = {
      OnCalendar = "hourly";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  # Daily reminder
  systemd.user.services.notify-stats = {
    Unit.Description = "Reminder: record statistics";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.libnotify}/bin/notify-send 'Record statistics'";
    };
  };
  systemd.user.timers.notify-stats = {
    Unit = {
      Description = "Daily statistics reminder";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Timer = {
      OnCalendar = "*-*-* 06:30:00";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
