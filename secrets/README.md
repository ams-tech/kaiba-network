## kaiba-network secrets

This flake provides:

* A [NixOS module](https://nixos.wiki/wiki/NixOS_modules) 

We're largely following [this tutorial](https://blakesmith.me/2024/03/02/running-nixos-tests-with-flakes.html) to structure this Flake; check it out.

### Generate a personal keypair

`mkdir -p ~/.config/sops/age`

`nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt`

And get the associated public key with

`nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt`

