{
  ...
}:
{
  services.nginx = {
    enable = true;
    virtualHosts."kaiba.network" = {
      locations."/" = {
        return = "200 '<html><body>it works, bitch.</body></html>'";
        extraConfig = ''
          default_type text/html;
        '';
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "info@kaiba.network";
  };
}