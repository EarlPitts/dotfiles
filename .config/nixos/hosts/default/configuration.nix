{ config, lib, pkgs, callPackage, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./main-user.nix
    ./jobs.nix
    inputs.home-manager.nixosModules.default
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "T480"; # Define your hostname.
  networking.wireless.iwd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 9090 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  time.timeZone = "Europe/Budapest";

  main-user.enable = true;
  main-user.userName = "ben";

  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true; # Needed for sound?

  services = {
    fwupd.enable = true;
    openssh.enable = true;
    dbus.enable = true;
    libinput.enable = true;
    udisks2.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      xkb.layout = "us";
      autoRepeatDelay = 250;
      autoRepeatInterval = 30;
      resolutions = [{
        x = 1920;
        y = 1080;
      }];

      displayManager.startx.enable = true;

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [ rofi i3blocks i3lock-color ];
      };
    };

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = { main = { capslock = "overload(control, esc)"; }; };
        };
      };
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "ben" = import ./home.nix; };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    fira-code-symbols
    font-awesome
  ];

  environment.systemPackages = with pkgs; [ vim wget ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.zsh = {
    enableCompletion = false;
    enable = true;
  };
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  programs.virt-manager.enable = true;

  services.throttled = {
    enable = true;
    extraConfig = ''
      [GENERAL]
      Enabled: True
      Sysfs_Power_Path: /sys/class/power_supply/AC*/online
      Autoreload: True

      [BATTERY]
      Update_Rate_s: 30
      PL1_Tdp_W: 29
      PL1_Duration_s: 28
      PL2_Tdp_W: 44
      PL2_Duration_S: 0.002
      Trip_Temp_C: 85
      cTDP: 0
      Disable_BDPROCHOT: False

      [AC]
      Update_Rate_s: 5
      PL1_Tdp_W: 44
      PL1_Duration_s: 28
      PL2_Tdp_W: 44
      PL2_Duration_S: 0.002
      Trip_Temp_C: 95
      cTDP: 0
      Disable_BDPROCHOT: False

      [UNDERVOLT.BATTERY]
      CORE: -85
      GPU: -85
      CACHE: -85
      UNCORE: -85
      ANALOGIO: 0

      [UNDERVOLT.AC]
      CORE: 0
      GPU: 0
      CACHE: 0
      UNCORE: 0
      ANALOGIO: 0
    '';
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "performance";

      CPU_ENERGY_PERF_POLICY_ON_AC = ""; # Needed for throttled

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 40;

      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };

  environment.pathsToLink = [ "/libexec" ];

  # Lowbat suspend and lock
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="${pkgs.systemd}/bin/systemctl suspend"
  '';

  # TODO Hard coded user, use coreutils instead of bash/gawk?
  systemd.services.wakelock = {
    enable = true;
    description = "Lock the screen on resume from suspend";
    path = [ pkgs.bash pkgs.i3lock-color pkgs.gawk pkgs.xorg.xdpyinfo ];
    unitConfig = { Before = [ "suspend.target" "sleep.target" ]; };
    serviceConfig = {
      ExecStart = "/home/ben/.local/bin/lock";
      Type = "forking";
      User = "ben";
      Environment = "DISPLAY=:0";
    };
    wantedBy = [ "suspend.target" "sleep.target" ];
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # powerManagement = {
  #   enable = true;
  #   resumeCommands = ''
  #       resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
  #
  #       FONT_COLOR=09050390
  #
  #       if [ "$resolution" = "1920x1080" ]; then
  #           wallpaper="/home/$USER/.local/share/wallpapers/lockScreen.jpg"
  #       else
  #           wallpaper="/home/$USER/.local/share/wallpapers/lockScreenSmall.jpg"
  #       fi
  #
  #       i3lock -u -k -e \
  #           --time-str="%H:%M" --time-color=$FONT_COLOR --time-size=45 \
  #           --date-str="%B %d, %A" --date-color=$FONT_COLOR \
  #           --greeter-text="Hi, I'm a computer." --greeter-color=$FONT_COLOR --greeter-pos="ix:h/2.4"
  #       --greeter-size=40 \
  #           -i "$wallpaper" \
  #           --pass-media-keys
  #   '';
  # };

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
