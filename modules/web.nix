{
  ...
}:
{
  services.nginx = {
    enable = true;
    virtualHosts.localhost = {
      locations."/" = {
        return = "200 '<html><body>it works, bitch.</body></html>'";
        extraConfig = ''
          default_type text/html;
        '';
      };
    };
  };
}