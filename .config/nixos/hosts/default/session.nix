# X11 session services (startx + i3)
{ config, pkgs, ... }:

let
  lock = import ./lock.nix { inherit pkgs; };

  # grobi helpers
  xrandr = "${pkgs.xrandr}/bin/xrandr";
  wallpaper = "${pkgs.feh}/bin/feh --no-fehbg --bg-fill ${config.home.homeDirectory}/.local/share/wallpapers/background.jpg";
  audio =
    profile:
    "${pkgs.pulseaudio}/bin/pactl set-card-profile alsa_card.pci-0000_00_1f.3 ${profile}+input:analog-stereo";
  # Use a single external output when it's connected.
  single = name: output: extra: {
    inherit name;
    outputs_connected = [ output ];
    atomic = true;
    configure_single = output;
    execute_after = extra ++ [ wallpaper ];
  };
in
{
  # startx doesn't activate graphical-session.target (it refuses manual start),
  # so xinitrc starts this target, which binds it.
  systemd.user.targets.x11-session.Unit = {
    Description = "X11 session (startx + i3)";
    BindsTo = [ "graphical-session.target" ];
    Wants = [ "graphical-session-pre.target" ];
    After = [ "graphical-session-pre.target" ];
  };

  services = {
    screen-locker = {
      enable = true;
      lockCmd = "${lock}/bin/lock";
      inactiveInterval = 10;
      xautolock.enable = false;
      xss-lock.extraOptions = [ "--transfer-sleep-lock" ];
    };

    grobi = {
      enable = true;
      settings = {
        on_failure = [ "${xrandr} --auto" ];
        rules = [
          (single "Home" "DP-1" [
            "${xrandr} --output DP-1 --gamma 0.9"
            (audio "output:analog-stereo")
          ])
          (single "Home2" "DP-2" [
            "${xrandr} --output DP-2 --gamma 0.9"
            (audio "output:analog-stereo")
          ])
          (single "HDMI" "HDMI-2" [ (audio "output:hdmi-stereo") ])
          {
            name = "Mobile";
            outputs_disconnected = [
              "DP-1"
              "DP-2"
              "HDMI-1"
              "HDMI-2"
            ];
            configure_single = "eDP-1";
            atomic = true;
            execute_after = [
              "${xrandr} --output eDP-1 --gamma 0.9"
              wallpaper
              (audio "output:analog-stereo")
            ];
          }
        ];
      };
    };

    dunst = {
      enable = true;
      settings = {
        global = {
          monitor = 0;
          follow = "mouse";
          width = 250;
          height = 30;
          offset = "10x10";
          indicate_hidden = true;
          transparency = 0;
          separator_height = 3;
          padding = 10;
          horizontal_padding = 10;
          frame_width = 3;
          frame_color = "#d3d0c8";
          separator_color = "#d3d0c8";
          sort = true;
          idle_threshold = 120;
          font = "Liberation Mono 10";
          line_height = 5;
          markup = "full";
          format = "<b>%s</b>\\n%b";
          alignment = "left";
          show_age_threshold = 60;
          word_wrap = true;
          ignore_newline = false;
          stack_duplicates = true;
          hide_duplicate_count = false;
          icon_position = "off";
          max_icon_size = 32;
          sticky_history = true;
          history_length = 20;
        };

        urgency_low = {
          background = "#393939";
          foreground = "#747369";
          timeout = 10;
        };

        urgency_normal = {
          background = "#515151";
          foreground = "#d3d0c8";
          timeout = 10;
        };

        urgency_critical = {
          background = "#f2777a";
          foreground = "#e8e6df";
          frame_color = "#bf616a";
          timeout = 0;
        };
      };
    };

    # Automount drives
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "never";
    };

    # Hide the cursor
    unclutter = {
      enable = true;
      timeout = 5;
    };
  };
}
