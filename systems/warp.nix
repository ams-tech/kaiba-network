# "Warp" is a physical Raspberry Pi 5 in my home. It runs NixOS and is configured using this flake.
# This system serves as the "trusted host" for "kaiba.network" for the limited "trusted host" operations our platform needs.
# Longer term, the "trusted host" operations should be distributed across multiple hosts, but for now, this is a single point of failure for the "trusted host" operations.
{
  nixos-raspberrypi,
  inputs,
  kaiba_network_modules,
  ...
}:
nixos-raspberrypi.lib.nixosSystem {
          specialArgs = inputs;
          modules = [
            ({...}: {
              imports = with nixos-raspberrypi.nixosModules; [
                raspberry-pi-5.base
                raspberry-pi-5.bluetooth
                kaiba_network_modules.homeserver
              ];
              boot.loader.raspberry-pi.bootloader = "kernel";
            })
            ({ ... }: {
              nix = {
                settings = {
                  experimental-features = [ "nix-command" "flakes" ];
                };
              };
            })
            ({ ... }: {
              networking.hostName = "warp";
              networking.firewall.enable = true;
              networking.firewall.allowedTCPPorts = [ 80 443 ];
              networking.nameservers = [ "8.8.8.8" "8.8.4.4" "2001:4860:4860::8888" "2001:4860:4860::8844"];
              
              users.users.adam = {
                isNormalUser = true;
                extraGroups = [
                  "wheel"
                ];
                openssh.authorizedKeys.keys = [
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJMjtOqSWLDq79t/9XljmBrfBVm8deQJdOQmTV7c45Ni adam" # content of authorized_keys file
                ];
              };
              security.sudo.wheelNeedsPassword = false;
              services.openssh.enable = true;
              services.avahi = {
                enable = true;
                nssmdns4 = true;
              };
              services.pcscd.enable = true;
            })
            ({ ... }: {
              fileSystems = {
                "/boot/firmware" = {
                  device = "/dev/disk/by-uuid/2175-794E";
                  fsType = "vfat";
                  options = [
                    "noatime"
                    "noauto"
                    "x-systemd.automount"
                    "x-systemd.idle-timeout=1min"
                  ];
                };
                "/" = {
                  device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
                  fsType = "ext4";
                  options = [ "noatime" ];
                };
                "/data" = {
                  device = "/dev/nvmen1p1";
                  fsType = "ext4";
                  options = [ "noatime" ];
                };
              };
            })
          ];
        }
