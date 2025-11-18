# nixos config


local switch
```bash
sudo -E nixos-rebuild switch --flake .#pc_1
```

list generations
```bash
nixos-rebuild list-generations
```

delete old generations than 1 day
```bash
sudo nix-collect-garbage --delete-older-than 1d
```

remote switch(not frequently)
```bash
sudo -E nixos-rebuild switch --flake github:yebei199/nixos_config#pc_1
```

See an overview of the flake outputs by running
```bash
nix flake show github:yebei199/nixos_config
```
