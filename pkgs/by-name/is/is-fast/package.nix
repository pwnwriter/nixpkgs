{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  oniguruma,
  openssl,
  sqlite,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "is-fast";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "Magic-JD";
    repo = "is-fast";
    tag = "v${version}";
    hash = "sha256-exC9xD0scCa1jYomBCewaLv2kzoxSjHhc75EhEERPR8=";
  };

  useFetchCargoVendor = true;

  cargoHash = "sha256-r1neLuUkWVKl7Qc4FNqW1jzX/HHyVJPEqgZV/GYkGRU=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs =
    [
      oniguruma
      openssl
      sqlite
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
    ];

  env = {
    OPENSSL_NO_VENDOR = true;
    RUSTONIG_SYSTEM_LIBONIG = true;
  };

  meta = {
    description = "Check the internet as fast as possible";
    homepage = "https://github.com/Magic-JD/is-fast";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ pwnwriter ];
    mainProgram = "is-fast";
  };
}
