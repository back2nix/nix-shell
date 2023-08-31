{ lib
, stdenv
, fetchFromGitHub
, pkgs
}:

stdenv.mkDerivation {
  name = "paris-traceroute";
  version = "v0.93";

  src = fetchFromGitHub {
    owner = "libparistraceroute";
    repo = "libparistraceroute";
    rev = "6fb8f4842d714a8997f70bc3f76584aae2f40a14";
    sha256 = "sha256-AKMPxhhOryGWZaTCSJL4P3hj+K7s15nkIBTH46+UEk4=";
  };

  postPatch = ''
    mkdir -p m4
    ./autogen.sh
    sed -i 's/CFLAGS="$CFLAGS -Wall -Werror"/CFLAGS="$CFLAGS"/g' configure.ac
  '';

  configureScript = ''
    ./configure
  '';

  buildInputs = [ 
    pkgs.automake
    pkgs.libtool
    pkgs.autoconf
  ];

  meta = with lib; {
    description = "libparistraceroute is a library written in C dedicated to active network measurements. Some example are also provided, such as paris-ping and the new implementation of paris-traceroute.";
    homepage = "https://paris-traceroute.net/";
    changelog = "https://sourceforge.net/projects/traceroute/files/traceroute/traceroute-${version}/";
    license = licenses.gpl3;
    maintainers = with maintainers; [ libparistraceroute ];
    platforms = platforms.linux;
  };

  hardeningDisable = [ "all" ];
}
