{ pkgs }:

pkgs.writeShellApplication {
  name = "lock";
  runtimeInputs = with pkgs; [
    i3lock-color
    xdpyinfo
    gawk
    procps
  ];
  text = ''
    resolution=$(xdpyinfo | awk '/dimensions:/ { print $2 }')
    font_color=09050390

    wallpaper="$HOME/.local/share/wallpapers/lockScreen.jpg"

    opts=(
      -u -k -e
      --time-str="%H:%M" --time-color="$font_color" --time-size=45
      --date-str="%B %d, %A" --date-color="$font_color"
      --greeter-text="Hi, I'm a computer." --greeter-color="$font_color"
      --greeter-pos="ix:h/2.4" --greeter-size=40
      -i "$wallpaper"
      --pass-media-keys
    )

    # Make suspend wait until locked
    if [[ -e /dev/fd/''${XSS_SLEEP_LOCK_FD:--1} ]]; then
      kill_i3lock() { pkill -xu "$EUID" "$@" i3lock-color; }
      trap kill_i3lock TERM INT

      # Don't leak the inhibitor fd into i3lock
      i3lock-color "''${opts[@]}" {XSS_SLEEP_LOCK_FD}<&-

      # Screen is locked: release the inhibitor so the system can suspend
      exec {XSS_SLEEP_LOCK_FD}<&-

      while kill_i3lock -0; do
        sleep 0.5
      done
    else
      trap 'kill %%' TERM INT
      i3lock-color -n "''${opts[@]}" &
      wait
    fi
  '';
}
