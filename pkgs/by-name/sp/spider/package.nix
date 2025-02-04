{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  rust-jemalloc-sys,
  sqlite,
  zstd,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "spider";
  version = "2.27.31";

  src = fetchFromGitHub {
    owner = "spider-rs";
    repo = "spider";
    rev = "55f269a05465f0f9e4fdd6e4ecb167032748063a";
    hash = "sha256-3/F+4sZQ3T7rnqVfGWFaroBxLBqtU3lfF+y9qhRyQkE=";
  };

  cargoHash = "sha256-Yyr6nwZZtuO2bt1Pza7WZIcEMCI2qCGtPvmMa2oWHBs=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    openssl
    rust-jemalloc-sys
    sqlite
    zstd
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.IOKit
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  env = {
    OPENSSL_NO_VENDOR = true;
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "A web crawler and scraper for Rust";
    homepage = "https://github.com/pwnwriter/spider/tree/main/spider_cli";
    changelog = "https://github.com/pwnwriter/spider/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ pwnwriter ];
    mainProgram = "spider";
  };
}
