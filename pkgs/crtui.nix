{
  lib,
  stdenv,
  fetchzip,
}:
let
  version = "0.4.1";
  plat = {
    "aarch64-darwin" = "darwin_arm64";
    "x86_64-darwin" = "darwin_amd64";
    "aarch64-linux" = "linux_arm64";
    "x86_64-linux" = "linux_amd64";
  };
in
stdenv.mkDerivation {
  pname = "crtui";
  inherit version;

  src = fetchzip {
    url = "https://github.com/ksckaan1/crtui/releases/download/v${version}/crtui_${version}_${
      plat.${stdenv.hostPlatform.system}
        or (throw "crtui: unsupported platform ${stdenv.hostPlatform.system}")
    }.tar.gz";
    hash = "sha256-Rue9l2dZR8J6+XCV4HGOvYywklDa9jq4I6IUlhmtTF8=";
    stripRoot = false; # tarball has no single top-level dir
  };

  # Prebuilt binary: skip fixup so llvm-strip does not invalidate the
  # ad-hoc Mach-O signature macOS arm64 requires.
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 $src/crtui $out/bin/crtui
    runHook postInstall
  '';

  meta = {
    description = "Terminal-based container registry management tool";
    homepage = "https://github.com/ksckaan1/crtui";
    license = lib.licenses.mit;
    mainProgram = "crtui";
    platforms = builtins.attrNames plat;
  };
}
