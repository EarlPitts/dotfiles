# st with scrollback + ligatures
{ pkgs }:

pkgs.st.override {
  conf = builtins.readFile ./st/config.h;
  extraLibs = [ pkgs.harfbuzz ]; # needed for ligatures patch
  # Order matters!
  patches = [
    # https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff
    ./st/patches/st-scrollback-0.9.2.diff
    # https://st.suckless.org/patches/ligatures/0.9.3/st-ligatures-scrollback-20251007-0.9.3.diff
    ./st/patches/st-ligatures-scrollback-20251007-0.9.3.diff
  ];
}
