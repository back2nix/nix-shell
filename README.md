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
