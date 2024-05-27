# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, callPackage, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./main-user.nix
      inputs.home-manager.nixosModules.default
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sdb"; # or "nodev" for efi only

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.wireless.iwd.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Budapest";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  main-user.enable = true;
  main-user.userName = "obabo";

  users.users.obabo.extraGroups = [ "libvirtd" "video" ];
  security.sudo.wheelNeedsPassword = false;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "obabo" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.udisks2.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.zsh = {
    enableCompletion = false;
    enable = true;
  };
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  virtualisation.libvirtd.enable = true;
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
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = ""; # Needed for throttled

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 40;

       START_CHARGE_THRESH_BAT1 = 75;
       STOP_CHARGE_THRESH_BAT1 = 80;
      };
  };

  
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    fira-code-symbols
    font-awesome
  ];

  environment.pathsToLink = [ "/libexec" ];

  # List services that you want to enable:
  services = {

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    dbus = {
      enable = true;
    };

    libinput.enable = true;

    xserver = {
      enable = true;  
      xkb.layout = "us";
      autoRepeatDelay = 250;
      autoRepeatInterval = 30;
      resolutions = [
      	{
		x = 1920;
		y = 1080;
	    }
	  ];

      displayManager.startx.enable = true;

      windowManager.i3 = {
      	enable = true;
        extraPackages = with pkgs; [
          rofi
          i3blocks
          i3lock-color
        ];
      };
    };

    interception-tools = {
      enable = true;
      plugins = with pkgs; [
		interception-tools-plugins.caps2esc
      ];
	  udevmonConfig = ''
- JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
        '';
    };
  };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

