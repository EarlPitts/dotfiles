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
        proxyPass = "http://localhost:8096";
        proxyWebsockets = true;
      };
    };
  };
}
