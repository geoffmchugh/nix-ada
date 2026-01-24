{ stdenv
, gnat
, fetchzip
, gprbuild
, gnatPackages
, libadalang
, zlib
, libbfd
, libopcodes
, libiberty
, binutils
, gnat_util
, templates-parser
, stable-sloc
, llvm
}:

with gnatPackages;
stdenv.mkDerivation rec {
  pname = "gnatcoverage";
  version = "26.0.0-20260123";
  
  src = fetchGit {
    url = "https://github.com/AdaCore/gnatcoverage.git";
    ref = "master";
    rev = "af2b6394255e4c7058c1b8c52e19f8801633a962";
  };

  patches = [ ./gnatcov.gpr.patch ./instrument-ada_unit.adb.patch ];
  
  nativeBuildInputs = [
    gprbuild
    gnat
    llvm
  ];

  buildInputs = [
    gnatcoll-core
    libadalang
    zlib
    libbfd
    libopcodes
    libiberty
    binutils
    gnat_util
    gpr2
    templates-parser
    stable-sloc
    llvm
  ];

  configurePhase = ''
    runHook preConfigure

    cd tools/gnatcov

    runHook postConfigure
  '';

  enableParallelBuilding = true;
  buildPhase = ''
    runHook preBuild

    make LIBRARY_TYPE=relocatable BUILD_MODE=prod C_SUPPORT=False all

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    # Skip examples
    make LIBRARY_TYPE=relocatable BUILD_MODE=prod C_SUPPORT=False PREFIX=$out install-bin install-gnatcov_rts install-lib

    runHook postInstall
  '';
}
