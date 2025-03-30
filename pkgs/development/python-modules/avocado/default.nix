{
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "avocado";
  version = "110.0";
  src = fetchFromGitHub {
    owner = "avocado-framework";
    repo = "avocado";
    tag = "${version}";
    hash = "sha256-BTVW6LKpfx5owS8p7kaID1XmQPLL2p/6cn804SuGEXk=";
  };
  format = "setuptools";
  dependencies = [ python3.pkgs.setuptools ];
  meta = with lib; {
    homepage = "https://github.com/avocado-framework/avocado";
    description = "Avocado is a set of tools and libraries to help with automated testing. One can call it a test framework with benefits. Native tests are written in Python and they follow the unittest pattern, but any executable can serve as a test. ";
    license = licenses.gpl2;
    maintainers = with maintainers; [ philipp8101 ];
  };
}
