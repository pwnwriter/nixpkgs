{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  udev,
  vulkan-loader,
  stdenv,
  darwin,
  alsa-lib,
}:

rustPlatform.buildRustPackage rec {
  pname = "ttysvr";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "cxreiff";
    repo = "ttysvr";
    rev = "v${version}";
    hash = "sha256-B99YXXgWIRDcALpM2UeiXmvNvs/wRhYovRbwH90oMU4=";
  };

  cargoHash = "sha256-v3S7R0wwv5AT+hsys2pTgwdAfEzloiFENjiOJuQwbuE=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs =
    [
      udev
      vulkan-loader
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreAudio
      darwin.apple_sdk.frameworks.CoreGraphics
      darwin.apple_sdk.frameworks.IOKit
      darwin.apple_sdk.frameworks.Metal
      darwin.apple_sdk.frameworks.QuartzCore
    ]
    ++ lib.optionals stdenv.isLinux [
      alsa-lib
    ];

  meta = {
    description = "Screen saver for your terminal";
    homepage = "https://github.com/cxreiff/ttysvr";
    changelog = "https://github.com/cxreiff/ttysvr/blob/${src.rev}/CHANGELOG.md";
    license = with lib.licenses; [
      asl20
      mit
    ];
    maintainers = with lib.maintainers; [ pwnwriter ];
    mainProgram = "ttysvr";
  };
}
