{ ... }:
{
  services = {
    immich = {
      enable = true;
      host = "127.0.0.1";
      mediaLocation = "/srv/immich";
      machine-learning.enable = false;
    };

    nginx.virtualHosts."pics.bendeguz.xyz" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:2283";
        proxyWebsockets = true;
      };
    };
  };
}
