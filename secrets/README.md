## Bootstrapping secrets

### Generate a personal keypair

`mkdir -p ~/.config/sops/age`

`nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt`

And get the associated public key with

`nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt`

