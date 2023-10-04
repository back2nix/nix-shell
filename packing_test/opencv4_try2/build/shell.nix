{ pkgs ? import <nixpkgs> { } }:
let
  ocl-icd = pkgs.ocl-icd;
in
with pkgs;
pkgs.mkShell
{
  name = "opencv4-shell";

  # nativeBuildInputs
  buildInputs = with pkgs; [
    which
    cmake
    zlib
    pcre
    boost
    # pythonPackages.python
    gflags
    protobuf3_21
    ocl-icd
    hdf5
    gtk2
    gtk3
    libjpeg
    openjpeg
    libpng
    libtiff
    libwebp
    openexr
    ilmbase
  ];

  shellHook = ''
    old_word1="REPLACE_OPENCL_LIBRARY"
    new_word1="${ocl-icd}/lib/libOpenCL.so"

    old_word2="REPLACE_CMAKE_STRIP"
    new_word2="`which strip`"

    old_word3="REPLACE_CMAKE_RANLIB"
    new_word3="`which ranlib`"

    old_word4="REPLACE_CMAKE_AR"
    new_word4="`which ar`"

    old_word5="REPLACE_Protobuf_PROTOC_EXECUTABLE"
    new_word5="`which protoc`"

    cp Makefile.template Makefile
    sed -i "s|$old_word1|$new_word1|g" ./Makefile
    sed -i "s|$old_word2|$new_word2|g" ./Makefile
    sed -i "s|$old_word3|$new_word3|g" ./Makefile
    sed -i "s|$old_word4|$new_word4|g" ./Makefile
    sed -i "s|$old_word5|$new_word5|g" ./Makefile

  '';

  # hardeningDisable = [ "all" ];
}
