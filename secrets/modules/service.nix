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
  };
}
