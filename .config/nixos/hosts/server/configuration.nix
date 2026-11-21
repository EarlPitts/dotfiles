# # TODO
# - nginx
# - vsftpd?
# - git (password store!)
#
# new(?):
#   - prosody
#   - nectcloud
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
    ./hardening.nix
    ./services/badminbot.nix
    ./services/planning-poker.nix
    ./services/vikunja.nix
    ./services/microbin.nix
    ./services/immich.nix
    ./services/jellyfin.nix
    inputs.home-manager.nixosModules.default
  ];

  nix = {
    settings = {
      download-buffer-size = 134217728; # 128 MB
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      allowed-users = [
        "@wheel"
        "deploy"
      ];
      trusted-users = [
        "root"
        "ben"
        "deploy"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    optimise.automatic = true;
  };

  boot = {
    # Bootloader.
    loader.grub = {
      enable = true;
      device = "/dev/disk/by-id/ata-KINGSTON_SV300S37A240G_50026B7759058BED";
      configurationLimit = 10;
    };
    kernel.sysctl = {
      "kernel.sysrq" = 1; # Enable sysrq keys
      "vm.swappiness" = 100;
      "vm.page-cluster" = 0; # No swap readahead; pointless for zram
    };
  };

  # Compressed swap in RAM first
  zramSwap = {
    enable = true;
    algorithm = "lz4"; # cheaper than zstd
    memoryPercent = 50;
  };

  systemd.oomd.enable = false;
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 10;
    freeSwapThreshold = 50;
    extraArgs = [
      "--prefer"
      "^(immich|immich-api|jellyfin)$"
      "--avoid"
      "^(sshd|sshd-session|nginx|\\.postgres-wrapp|redis-server|systemd.*)$"
    ];
  };

  # Above this, immich is throttled and pushed to swap
  systemd.services.immich-server.serviceConfig.MemoryHigh = "1.5G";

  services.journald.settings.Journal.SystemMaxUse = "300M";

  networking = {
    hostName = "hub";

    # static IP
    useDHCP = false;
    interfaces.enp0s25.ipv4.addresses = [
      {
        address = "192.168.0.20";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.0.1";
    nameservers = [ "192.168.0.1" ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      3632
      443
      80
    ];
  };

  time.timeZone = "Europe/Budapest";

  main-user.enable = true;
  main-user.userName = "ben";

  users = {
    users.deploy = {
      isSystemUser = true;
      group = "deploy";
      shell = pkgs.bash;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWrYymEv5XhNLCasQv/3+NEdyPmm/UGtl0M7K1AFus8 github-actions-deploy"
      ];
    };
    groups.deploy = { };

    users.nginx.extraGroups = [ config.users.groups.anubis.name ];
  };

  security.sudo = {
    wheelNeedsPassword = false;
    extraRules = [
      {
        users = [ "deploy" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/systemctl restart badminbot";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/systemctl restart planning-poker";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  security.acme.acceptTerms = true;

  services = {
    logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchDocked = "ignore";
    };

    nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedTlsSettings = true;
      clientMaxBodySize = "512m";

      # reject non-matching vhosts
      virtualHosts."_" = {
        default = true;
        rejectSSL = true;
        locations."/".return = "444";
      };
    };

    fail2ban = {
      enable = true;
      maxretry = 3;
      bantime = "24h";
      bantime-increment = {
        enable = true;
        maxtime = "4w";
      };
      ignoreIP = [ "192.168.0.0/24" ]; # ignore LAN

      jails = {
        nginx-botsearch.settings = {
          enabled = true;
          filter = "nginx-botsearch";
          logpath = "/var/log/nginx/access.log";
          maxretry = 2;
          bantime = 86400;
        };

        nginx-bad-request.settings = {
          enabled = true;
          filter = "nginx-bad-request";
          logpath = "/var/log/nginx/access.log";
          maxretry = 2;
          bantime = 86400;
        };
      };
    };

    smartd = {
      enable = true;
      defaults.autodetected = "-a -o on -S on -n standby,q -s (S/../.././03|L/../10/./04)";
      extraOptions = [ "--interval=28800" ]; # every 8 hours
    };

    # Disable fan because it's noisy as hell
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
      guiAddress = "127.0.0.1:8384";
    };

    openssh = {
      enable = true;
      ports = [ 3632 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [
          "ben"
          "deploy"
        ];
        MaxAuthTries = 3;
        LoginGraceTime = 30;
        X11Forwarding = false;
        AllowAgentForwarding = false;
        ClientAliveInterval = 300;
        ClientAliveCountMax = 2;
      };

      # CI deploy key: no tunnels/forwarding/tty tricks
      extraConfig = ''
        Match User deploy
          AllowTcpForwarding no
          AllowStreamLocalForwarding no
          PermitTunnel no
          X11Forwarding no
      '';
    };

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
    rtorrent
  ];

  programs.zsh = {
    enableCompletion = false;
    enable = true;
  };

  environment.pathsToLink = [ "/libexec" ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
