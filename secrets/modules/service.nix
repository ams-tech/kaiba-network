{ config, lib, pkgs, ... }:

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
    systemd.services.hello = {
      description = "Says hello on login.";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.hello}/bin/hello -g 'Hello, User!'";
      };
    };
  };
}
