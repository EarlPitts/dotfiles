{ ... }:
{
  services = {
    immich = {
      enable = true;
      host = "0.0.0.0";
      mediaLocation = "/srv/immich";
      machine-learning.enable = false;
    };

    nginx.virtualHosts."pics.bendeguz.xyz" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:2283";
        proxyWebsockets = true;
      };
    };
  };
}
