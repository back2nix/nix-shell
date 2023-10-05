# Incremental build

- Экономить время на сборке debug проекта и проще отлаживать

### Stage 1

- Вытаскиваем prebuild folder из nix и сохраняем где нибудь в папку debug2

- правильно подготавливаем исходники чтобы можно было приступить к с сборке

```bash
make download
```

```bash
cp 1.stage.shell.nix shell.nix
nix-shell --pure
```

- shell.nix сбилдит проект с нужным флагами и патчами
- затем вручную скопировать все папки к себе в систему в любой удобный для вас путь, примерно так:

```bash
mkdir -p debug2/source
cd debug2/source
cp -r /nix/store/z47iqmixhnl9vb0h1znp41gfgwvkbzqm-opencv-4.7.0/* .
```

### Stage 2

- После подставляем сохраненный prebuild и nix уже не будет билдить с нуля

```bash
cp 2.stage.shell.nix shell.nix
nix-shell --pure
```

- в конце `nix-shell --pure` должен проинсталить вашу модифицированную opencv в систему и можно будет компилировать
- проекты которые используют opencv и отлаживать

### Test sample

- пример должен собраться
- если еще не запустили nix-shell

```bash
nix-shell --pure
```
- sample

```bash
cd sample
make configure
make build
cd build
```
- далее можно отлаживать 

```
gdb opencv_example
```
