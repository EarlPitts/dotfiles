# # TODO
# - Borg backups
# - Badminbot
# - smartmontools tests
# - nginx
# - tlp?
# - vsftpd?
# - automounts
# - git
#
# new(?):
#   - prosody
#   - jitsi meet
#   - raspberry stuff (spotify, gifs ...)

{
  config,
  lib,
  pkgs,
  callPackage,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./main-user.nix
    ./jobs.nix
    inputs.home-manager.nixosModules.default
  ];

  nix.settings = {
    download-buffer-size = 2147483648; # 2 GB
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "ben"
    ];
  };

  boot = {
    # Bootloader.
    loader.grub = {
      enable = true;
      device = "/dev/disk/by-id/wwn-0x5000c500190a5653";
    };
    kernel.sysctl."kernel.sysrq" = 1; # Enable sysrq keys
  };

  networking.hostName = "hub"; # Define your hostname.

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 9090 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false; # TODO

  time.timeZone = "Europe/Budapest";

  main-user.enable = true;
  main-user.userName = "ben";

  security.sudo.wheelNeedsPassword = false;

  services = {
    logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchDocked = "ignore";
    };

    # immich = {
    #   enable = true;
    #   port = 2283;
    #   host = "0.0.0.0";
    #   openFirewall = true;
    # };

    jellyfin.enable = true;

    thinkfan = {
      enable = true;
      levels = [
        [
          0
          0
          32767
        ]
      ];
    };

    syncthing = {
      enable = true;
      group = "wheel";
      user = "ben";
      dataDir = "/home/ben";
      configDir = "/home/ben/.config/syncthing";
      guiAddress = "0.0.0.0:8384";
    };

    openssh = {
      enable = true;
      ports = [ 3632 ];
    };
    libinput.enable = true;
    udisks2.enable = true;

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(control, esc)";
            };
          };
        };
      };
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ben" = import ./home.nix;
    };
  };

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

  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.earlyoom = {
    enable = true;
    reportInterval = 0;
  };

  environment.pathsToLink = [ "/libexec" ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
