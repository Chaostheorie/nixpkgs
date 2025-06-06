{
  lib,
  stdenv,
  fetchFromGitHub,
  openssl,
  lua,
  pcre2,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "imapfilter";
  version = "2.8.3";

  src = fetchFromGitHub {
    owner = "lefcha";
    repo = "imapfilter";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-9uPcdxZioXfdSuZO/fgtoIbQdWtc2DRr28iTonnG05U=";
  };
  makeFlags = [
    "SSLCAFILE=/etc/ssl/certs/ca-bundle.crt"
    "PREFIX=$(out)"
  ];

  buildInputs = [
    openssl
    pcre2
    lua
  ];

  meta = {
    homepage = "https://github.com/lefcha/imapfilter";
    description = "Mail filtering utility";
    mainProgram = "imapfilter";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ doronbehar ];
  };
})
