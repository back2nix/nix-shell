### How use

- Generate private and public keys and uuid
- and replace xrayConfig in flake.nix
- if not generate-config by default example for localhost and example keys

```
nix run .#generate-config
nix run "github:back2nix/nix-shell?dir=flake_xray#generate-config"
```
- use

```bash
nix run .#server
nix run .#client
 # for check proxy. analog 'proxychains4 curl https://ifconfig.me'
nix run .#run-through-proxy
```
-  or

```bash
nix run "github:back2nix/nix-shell?dir=flake_xray#server"
nix run "github:back2nix/nix-shell?dir=flake_xray#client"
 # for check proxy. analog 'proxychains4 curl https://ifconfig.me'
nix run "github:back2nix/nix-shell?dir=flake_xray#run-through-proxy"
```

### Error

```bash
error: experimental Nix feature 'nix-command' is disabled; add '--extra-experimental-features nix-command' to enable it
error: experimental Nix feature 'flakes' is disabled; add '--extra-experimental-features flakes' to enable it
```

- fix:

```bash
nix run --extra-experimental-features nix-command --extra-experimental-features flakes "github:back2nix/nix-shell?dir=flake_xray#generate-config"
nix run --extra-experimental-features nix-command --extra-experimental-features flakes "github:back2nix/nix-shell?dir=flake_xray#server"
nix run --extra-experimental-features nix-command --extra-experimental-features flakes "github:back2nix/nix-shell?dir=flake_xray#client"
nix run --extra-experimental-features nix-command --extra-experimental-features flakes "github:back2nix/nix-shell?dir=flake_xray#run-through-proxy"
```

- update flake

```bash
nix run --refresh --extra-experimental-features nix-command --extra-experimental-features flakes "github:back2nix/nix-shell?dir=flake_xray#generate-config"
nix run --refresh --extra-experimental-features nix-command --extra-experimental-features flakes "github:back2nix/nix-shell?dir=flake_xray#server"
nix run --refresh --extra-experimental-features nix-command --extra-experimental-features flakes "github:back2nix/nix-shell?dir=flake_xray#client"
nix run --refresh --extra-experimental-features nix-command --extra-experimental-features flakes "github:back2nix/nix-shell?dir=flake_xray#run-through-proxy"
```
