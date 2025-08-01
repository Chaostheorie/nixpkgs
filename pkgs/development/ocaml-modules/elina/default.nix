{
  stdenv,
  lib,
  fetchurl,
  gnumake42,
  perl,
  gmp,
  mpfr,
  ocaml,
  findlib,
  camlidl,
  apron,
}:

stdenv.mkDerivation rec {
  version = "1.1";
  pname = "ocaml${ocaml.version}-elina";
  src = fetchurl {
    url = "http://files.sri.inf.ethz.ch/elina-${version}.tar.gz";
    sha256 = "1nymykskq1yx87y4xl6hl9i4q6kv0qaq25rniqgl1bfn883p1ysc";
  };

  # fails with make 4.4
  nativeBuildInputs = [
    gnumake42
    perl
    ocaml
    findlib
    camlidl
  ];

  propagatedBuildInputs = [
    apron
    gmp
    mpfr
  ];

  strictDeps = true;

  prefixKey = "--prefix ";
  configureFlags = [
    "--use-apron"
    "--use-opam"
    "--apron-prefix"
    apron
  ]
  ++ lib.optional stdenv.hostPlatform.isDarwin "--absolute-dylibs";

  createFindlibDestdir = true;

  meta = {
    description = "ETH LIbrary for Numerical Analysis";
    homepage = "https://elina.ethz.ch/";
    license = lib.licenses.lgpl3;
    maintainers = [ lib.maintainers.vbgl ];
    platforms = lib.intersectLists ocaml.meta.platforms lib.platforms.x86;
  };
}
