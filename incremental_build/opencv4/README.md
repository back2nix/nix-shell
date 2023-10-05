# Incremental build

- Экономить время на сборке debug проекта и проще отлаживать

### Stage 1

- Вытаскиваем prebuild folder из nix и сохраняем где нибудь в папку debug2

- правильно подготавливаем исходники чтобы можно было приступить к с сборке

```bash
make download
```

```bash
make stage1-build
```

- shell.nix сбилдит проект с нужным флагами и патчами
- затем вручную скопировать все папки к себе в систему в любой удобный для вас путь, примерно так:
- путь пребилдом будет напечатан когда зафейлится первая стадия

```bash
mkdir -p debug/source
cd debug/source
cp -r /nix/store/z47iqmixhnl9vb0h1znp41gfgwvkbzqm-opencv-4.7.0/* .
```

### Stage 2

- После подставляем сохраненный prebuild и nix уже не будет билдить с нуля

```bash
nix-shell
```

- в конце `nix-shell --pure` должен проинсталить вашу модифицированную opencv в систему и можно будет компилировать
- проекты которые используют opencv и отлаживать

### Test sample

- пример должен собраться
- если еще не запустили nix-shell

```bash
nix-shell
```
- sample

```bash
cd sample
make configure
make build
cd build
```
- далее можно отлаживать, но gdb + `~/.gdbinit` должен быть вот этот https://github.com/symphorien/nixseparatedebuginfod, чтобы он видил отладочные символы

```
gdb opencv_example
```

# clean garbage

```bash
nix-store --gc
```
