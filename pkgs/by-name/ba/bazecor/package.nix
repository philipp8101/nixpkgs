{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchYarnDeps,
  yarnConfigHook,
  yarnBuildHook,
  yarnInstallHook,
  nodejs,
  libudev-zero,
  squashfsTools,
  python3,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "bazecor";
  version = "1.6.5";

  src = fetchFromGitHub {
    owner = "Dygmalab";
    repo = "bazecor";
    rev = "v${finalAttrs.version}";
    hash = "sha256-hPRD515VETYNLY/evgXACXQkgoxzc/ckOzAMbQ110d8=";
  };

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = finalAttrs.src + "/yarn.lock";
    hash = "sha256-oCi/EOGcjvXyw6jPBzLxqgGNTnGVivOVgQiNHiQA61k=";
  };
  yarnBuildScript = "make-lin";
  nativeBuildInputs = [
    yarnConfigHook
    yarnBuildHook
    yarnInstallHook
    # Needed for executing package.json scripts
    nodejs
    libudev-zero
    squashfsTools
    python3
  ];

  meta = {
    description = "Graphical configurator for Dygma Products";
    homepage = "https://github.com/Dygmalab/Bazecor";
    changelog = "https://github.com/Dygmalab/Bazecor/releases/tag/v${finalAttrs.version}";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      amesgen
      gcleroux
    ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "bazecor";
  };
})
