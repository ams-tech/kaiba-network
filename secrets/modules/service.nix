{ config, lib, pkgs, ... }:

let
  cfg = config.services.kaibaNetworkSecretsTest;
in {
  # To enable the service for decoding secrets, you need to set `services.helloNixosTests.enable = true`
  options = {
    services.kaibaNetworkSecretsTest = {
      enable = lib.mkEnableOption "kaibaNetworkSecretsTest";
    };
  };

  # If we've enabled the `kaibaNetworkService`, set the "config" attribute with this module's attributes
  config = lib.mkIf cfg.enable {
    sops.secrets."kaiba-network-test-secret" = {
      owner = "sometestservice";
    };
    # Create a unique user for our service
    users.users.kaiba-network-test-secret = {
      home = "/var/lib/kaiba-network-test-secret";
      createHome = true;
      description = "User for the kaibaNetworkSecretsTest service";
      isSystemUser = true;
      group = "kaiba-network-test-secret";
    };
    users.groups.kaiba-network-test-secret = { };

    # Create a service that, for now, just prints out the sample secret.kaiba-network-test-secret
      systemd.services."kaiba-network-test-secret" = {
      script = ''
          echo "
          Hey bro! I'm a service, and imma send this secure password:
          $(cat ${config.sops.secrets."kaiba-network-test-secret".path})
          located in:
          ${config.sops.secrets."kaiba-network-test-secret".path}
          to database and hack the mainframe
          " > /var/lib/kaiba-network-test-secret/testfile
        '';
      serviceConfig = {
        User = "kaiba-network-test-secret";
        WorkingDirectory = "/var/lib/kaiba-network-test-secret";
      };
    };
  };
}
