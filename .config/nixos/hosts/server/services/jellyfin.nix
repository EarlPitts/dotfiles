{ ... }:
{
  services = {
    jellyfin = {
      enable = true;
      dataDir = "/srv/jellyfin";
    };

    nginx.virtualHosts."movies.bendeguz.xyz" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
        proxyWebsockets = true;
      };
    };
  };
}
