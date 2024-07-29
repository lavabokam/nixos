{pkgs ? import <nixpkgs> {} , ...}:   
pkgs.stdenv.mkDerivation {
  name = "intel-sde";
  version = "9.33.0";
  src = pkgs.fetchurl {
    url = "https://downloadmirror.intel.com/813591/sde-external-9.33.0-2024-01-07-lin.tar.xz";
    hash = "sha256-Wt8OKxEyOZTrz36Qa+OwQMygJwQF4MGuFuVwoNgWrpc=";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook # Automatically setup the loader, and do the magic
    
  ];
  buildInputs = [
    pkgs.glibc
    pkgs.gcc-unwrapped
  ];
  buildPhase = ''
    pwd
  '';
 installPhase = ''
  mkdir -p $out/bin 
  cp -r ./* $out/bin
'';
}



