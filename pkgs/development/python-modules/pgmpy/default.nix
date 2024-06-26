{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  # build inputs
  networkx,
  numpy,
  scipy,
  scikit-learn,
  pandas,
  pyparsing,
  torch,
  statsmodels,
  tqdm,
  joblib,
  opt-einsum,
  # check inputs
  pytestCheckHook,
  pytest-cov,
  coverage,
  mock,
  black,
}:
let
  pname = "pgmpy";
  version = "0.1.25";
in
# optional-dependencies = {
#   all = [ daft ];
# };
buildPythonPackage {
  inherit pname version;
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "pgmpy";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-d2TNcJQ82XxTWdetLgtKXRpFulAEEzrr+cyRewoA6YI=";
  };

  propagatedBuildInputs = [
    networkx
    numpy
    scipy
    scikit-learn
    pandas
    pyparsing
    torch
    statsmodels
    tqdm
    joblib
    opt-einsum
  ];

  disabledTests = [
    "test_to_daft" # requires optional dependency daft
  ];

  nativeCheckInputs = [
    pytestCheckHook
    # xdoctest
    pytest-cov
    coverage
    mock
    black
  ];

  meta = with lib; {
    description = "Python Library for learning (Structure and Parameter), inference (Probabilistic and Causal), and simulations in Bayesian Networks";
    homepage = "https://github.com/pgmpy/pgmpy";
    changelog = "https://github.com/pgmpy/pgmpy/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ happysalada ];
  };
}
