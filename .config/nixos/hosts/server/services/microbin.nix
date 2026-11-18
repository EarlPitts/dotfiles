{
  config,
  ...
}:
{
  services = {
    microbin = {
      enable = true;
      dataDir = "/srv/bin";
      settings = {
        MICROBIN_BIND = "127.0.0.1";
        MICROBIN_MAX_FILE_SIZE_UNENCRYPTED_MB = 512;
        MICROBIN_NO_LISTING = true;
      };
    };

    anubis.instances."bin" = {
      enable = true;
      settings = {
        TARGET = "http://localhost:8080";
        BIND = "/run/anubis/anubis-bin/anubis.sock";
      };
    };

    nginx.virtualHosts."bin.bendeguz.xyz" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://unix:${config.services.anubis.instances.bin.settings.BIND}";
        extraConfig = ''
          proxy_set_header X-Real-IP $remote_addr;
        '';
      };
    };
  };
}
