{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "mozlz4";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "jusw85";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-faoFvDvqCr0EPsqlQvHZpd74b5pzYhtkJ6gXebwEm/w=";
  };

  # update the Cargo.lock file since getch-cargo-vendor-util cant handle the older format used in src
  # we have to use postUnpack instead of patches, because patches are not applied before fetch-cargo-vendor-util is executed
  postUnpack = ''
    cd source
    patch < ${./update-cargo-lock.patch}
    cd ..
  '';

  cargoHash = "sha256-rhVNBYvN7q9AZ2K8LYHsL/E7Y7XD5I59OervLaf9GJ4=";
  useFetchCargoVendor = true;

  meta = {
    description = "Decompress / compress mozlz4 files, with precompiled binaries for Windows and Linux";
    homepage = "https://github.com/jusw85/mozlz4";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.philipp8101 ];
  };
}
