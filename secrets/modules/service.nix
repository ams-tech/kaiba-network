{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.services.kaibaNetworkSecretsTest;
in
{
  # To enable the service for decoding secrets, you need to set `services.helloNixosTests.enable = true`
  options = {
    services.kaibaNetworkSecretsTest = {
      enable = lib.mkEnableOption "kaibaNetworkSecretsTest";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.kaiba-network-secrets-test = {
      createHome = true;
      isSystemUser = true;
      group = "kaiba-network-secrets-test";
      home = "/var/lib/kaiba-network-secrets-test";
    };
    users.groups.kaiba-network-secrets-test = { };
    systemd.services.sometestservice = {
      description = "helloNixosTests server";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      script = ''
        echo "hello world" > /var/lib/kaiba-network-secrets-test/test.txt
      '';

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = "kaiba-network-secrets-test";
        Group = "kaiba-network-secrets-test";
      };
    };
  };
}
