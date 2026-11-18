{
  config,
}:
{

  # I couldn't set the db path, because of sandboxing
  fileSystems."/var/lib/private/vikunja" = {
    device = "/srv/vikunja";
    options = [ "bind" ];
    fsType = "non";
  };

  systemd.services.vikunja = {
    requires = [ "var-lib-private-vikunja.mount" ];
    after = [ "var-lib-private-vikunja.mount" ];
  };

  services = {
    vikunja = {
      enable = true;
      frontendScheme = "https";
      frontendHostname = "todo.bendeguz.xyz";
      settings.service.enableregistration = false;
    };

    anubis.instances."todo" = {
      enable = true;
      settings = {
        TARGET = "http://localhost:3456";
        BIND = "/run/anubis/anubis-todo/anubis.sock";
      };
    };

    nginx.virtualHosts."todo.bendeguz.xyz" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://unix:${config.services.anubis.instances.todo.settings.BIND}";
        extraConfig = ''
          proxy_set_header X-Real-IP $remote_addr;
        '';
        proxyWebsockets = true;
      };
    };
  };
}
