# example nix-shell

```
cd golang
nix-shell
```

# auto activate env

create file `.envrc` with content:

```
use_nix
```

use command in folder where .envrc:

```
direnv allow
```

# overide shell stdenv

```nix
pkgs.mkShell.override { stdenv = pkgs.gcc11Stdenv; } {
    name = "my-override-shell";
    buildInputs = with pkgs.python310Packages; [
    ];
}
```
