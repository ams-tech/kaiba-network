{ pkgs, inputs, config, ... }:

{
  imports =
  [
    # Import "sops-nix" from the provided pkgs attribute set
    pkgs.sops
  ];
  services.pcscd.enable = true;

  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  
  sops.age.keyFile = "/home/user/.config/sops/age/keys.txt";
}

