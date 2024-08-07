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
