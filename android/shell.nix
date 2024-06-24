with import <nixpkgs> { }; let
  pythonPackages = python310Packages;
in
pkgs.mkShell
rec {
  name = "openVoice";
  doCheck = false;

  buildInputs = with pythonPackages; [
    # python
    # pip

    venvShellHook
    # jupyter-all

    # pandas
    # numpy
    # matplotlib
    # sklearn-deap

    # PyExecJS

    # torchWithCuda
    # pytorch-bin
    # librosa
    # faster-whisper
    # pydub
    # inflect
    # unidecode
    # openai
    # # openai-triton-cuda
    # openai-triton
    # typing-extensions
    # python-dotenv
    # pypinyin
    # jieba
    # gradio
    # langid
    # huggingface-hub
    # starlette
    # anyio

    # numpy
    # requests
    # flask
    # flask-babel
    # browser-cookie3
    # aiohttp
    # pycrypto
    # taglib
    # openssl
    # git
    # libxml2
    # libxslt
    systemd
    pkg-config
    jadx
    radare2
    frida-tools
    libzip
    zlib
    pkgs.stdenv.cc.cc.lib
  ];

  venvDir = "venv310";

  postShellHook = ''
    pip install -r requirements.txt
    # r2pm -U
    # r2pm -ci r2frida
  '';
}
