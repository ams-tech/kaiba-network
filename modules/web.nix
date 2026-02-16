{
  ...
}:
{
  services.nginx = {
    enable = true;
    virtualHosts."kaiba.network" = {
      enableACME = true;
      forceSSL = true;
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