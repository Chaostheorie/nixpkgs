{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  netbox,
}:
buildPythonPackage rec {
  pname = "netbox-floorplan-plugin";
  version = "0.5.0";
  # pyproject = true;

  src = fetchFromGitHub {
    owner = "netbox-community";
    repo = "netbox-floorplan-plugin";
    rev = version;
    hash = "sha256-tN07cZKNBPraGnvKZlPEg0t8fusDkBc2S41M3f5q3kc=";
  };

  nativeBuildInputs = [ setuptools ];

  nativeCheckInputs = [ netbox ];

  preFixup = ''
    export PYTHONPATH=${netbox}/opt/netbox/netbox:$PYTHONPATH
  '';

  pythonImportsCheck = [ "netbox_floorplan" ];

  meta = with lib; {
    description = "A netbox plugin providing floorplan mapping capability for locations and sites";
    homepage = "https://github.com/netbox-community/netbox-floorplan-plugin";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ cobalt ];
  };
}
