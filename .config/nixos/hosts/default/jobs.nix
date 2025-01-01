{ pkgs, ... }: {
  systemd.timers."mail" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "mail.service";
    };
  };

  systemd.services."mail" = {
    path = [ pkgs.gnupg pkgs.rofi pkgs.rofi-pass ];
    script = ''
      set -eu
      ${pkgs.isync}/bin/mbsync -a
    '';
    after = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "ben";
      Environment = "DISPLAY=:0";
    };
  };

  systemd.timers."rss" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "1h";
      OnUnitActiveSec = "1h";
      Unit = "rss.service";
    };
  };

  systemd.services."rss" = {
    script = ''
      set -eu
      ${pkgs.newsboat}/bin/newsboat -x reload
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "ben";
    };
  };

  systemd.timers."notify" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 06:30:00";
      Unit = "notify.service";
    };
  };

  systemd.services."notify" = {
    path = [ pkgs.dbus ];
    script = ''
      set -eu
      ${pkgs.libnotify}/bin/notify-send "Record statistics"
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "ben";
      Environment = [
        "DISPLAY=:0"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
      ];
    };
  };
}
