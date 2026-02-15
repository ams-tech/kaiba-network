{
  ...
}:
{
  services.nginx = {
    enable = true;
    virtualHosts.localhost = {
      locations."/" = {
        return = "200 '<html><body>Bitch.</body></html>'";
        extraConfig = ''
          default_type text/html;
        '';
      };
    };
  };
}