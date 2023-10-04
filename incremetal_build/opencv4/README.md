# Incremetal build

### stage 1

- первый прогон можно оставить с неизмененным src 
- либо нужно подготовить исходники самому и разложить все правильно если мы хотим коммитить изменения кода
- патч можно наложить только если мы использовали git

```bash
cp 1.stage.shell.nix shell.nix
nix-shell --pure
```

- для этого можно использовать `make download`
- shell.nix позволит сбилдить проект с нужным флагами 
- затем вручную скопировать все папки к себе в систему в любой удобный для вас путь, примерно так:

```bash
mkdir -p debug2/source
cd debug2/source
cp -r /nix/store/z47iqmixhnl9vb0h1znp41gfgwvkbzqm-opencv-4.7.0/* .
```

### Stage 2

- после определить путь до этой папки в своей системе в src = , тогда компиляция будет проходить инкрементально

```bash
cp 2.stage.shell.nix shell.nix
nix-shell --pure
```

- в конце `nix-shell --pure` должен проинсталить вашу модифицированную opencv в систему и можно будет компилировать
- проекты которые используют opencv и отлаживать

### test sample

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