{
  pkgs ? import<nixpkgs> {},
  version ? "2024.2",
}:
let
  versions =
  {
    "2022.2" =
    {
      basekit =
      {
        id = "18673";
        version = "2022.2.0.262";
        sha256 = "03qx6sb58mkhc7iyc8va4y1ihj6l3155dxwmqj8dfw7j2ma7r5f6";
        components =
        [
          "intel.oneapi.lin.dpcpp-ct"
          "intel.oneapi.lin.dpcpp_dbg"
          "intel.oneapi.lin.dpl"
          "intel.oneapi.lin.tbb.devel"
          "intel.oneapi.lin.ccl.devel"
          "intel.oneapi.lin.dpcpp-cpp-compiler"
          "intel.oneapi.lin.dpl"
          "intel.oneapi.lin.mkl.devel"
        ];
      };
      hpckit =
      {
        id = "18679";
        version = "2022.2.0.191";
        sha256 = "0swz4w9bn58wwqjkqhjqnkcs8k8ms9nn9s8k7j5w6rzvsa6817d2";
      };
    };
    "2024.0" =
    {
      basekit =
      {
        id = "163da6e4-56eb-4948-aba3-debcec61c064";
        version = "2024.0.1.46";
        sha256 = "1sp1fgjv8xj8qxf8nv4lr1x5cxz7xl5wv4ixmfmcg0gyk28cjq1g";
      };
      hpckit =
      {
        id = "67c08c98-f311-4068-8b85-15d79c4f277a";
        version = "2024.0.1.38";
        sha256 = "06vpdz51w2v4ncgk8k6y2srlfbbdqdmb4v4bdwb67zsg9lmf8fp9";
      };
    };
  };
  builder = pkgs.buildFHSEnv
  {
    name = "builder";
    targetPkgs = pkgs: with pkgs; [ coreutils zlib  gcc hwloc ];
    extraBwrapArgs = [ "--bind" "$out" "$out" ];
    runScript = "sh";
  };
  componentString = components: if components == null then "--components default" else
    " --components " + (builtins.concatStringsSep ":" components);
in pkgs.stdenvNoCC.mkDerivation rec
{
  pname = "oneapi";
  inherit version;
#  basekit = pkgs.fetchurl
#  {
#    url = "https://registrationcenter-download.intel.com/akdlm/IRC_NAS/${versions.${version}.basekit.id}/"
#      + "l_BaseKit_p_${versions.${version}.basekit.version}_offline.sh";
#    sha256 = versions.${version}.basekit.sha256;
#  };
#  hpckit = pkgs.fetchurl
#  {
#    url = "https://registrationcenter-download.intel.com/akdlm/IRC_NAS/${versions.${version}.hpckit.id}/"
#      + "l_HPCKit_p_${versions.${version}.hpckit.version}_offline.sh";
#    sha256 = versions.${version}.hpckit.sha256;
#  };
  compilerkit = pkgs.fetchurl {
    url = "https://registrationcenter-download.intel.com/akdlm/IRC_NAS/6780ac84-6256-4b59-a647-330eb65f32b6/l_dpcpp-cpp-compiler_p_2024.2.0.495_offline.sh";
    hash = "sha256-lGOql5MU0qzFFHLUFP/O4DLphpyoWsb/THHTlQDlFz0=";
  };
  phases = [ "installPhase" "fixupPhase" ];
  #donotUnpack = true;
  nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.ncurses 
	pkgs.level-zero pkgs.elfutils ];
  installPhase =
  ''
    mkdir -p $out
    #${builder}/bin/builder ${compilerkit} -f icc -x
    #ls -lah icc/l_dpcpp-cpp-compiler_p_2024.2.0.495_offline/
    #${builder}/bin/builder icc/l_dpcpp-cpp-compiler_p_2024.2.0.495_offline/install.sh --silent --eula accept
    
    ${builder}/bin/builder ${compilerkit} -a --silent --eula accept --install-dir $out
    #${builder}/bin/builder $out/share/intel/modulefiles-setup.sh --output-dir=$out/share/intel/modulefiles  --ignore-latest
    ln -s $out/compiler/latest/bin $out/bin
    ln -s $out/compiler/latest/lib $out/lib
  '';
  autoPatchelfIgnoreMissingDeps = [ "libhwloc.so.5" ];
#  dontFixup = true;
#  requiredSystemFeatures = [ "gccarch-exact-${pkgs.stdenvNoCC}" "big-parallel" ];
  requiredSystemFeatures = [ "big-parallel" ];

}
