{
  lib,
  buildPythonPackage,
  fetchPypi,
  google-api-core,
  grpc-google-iam-v1,
  mock,
  proto-plus,
  protobuf,
  pytest-asyncio,
  pytestCheckHook,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "google-cloud-iam-logging";
  version = "1.4.1";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    pname = "google_cloud_iam_logging";
    inherit version;
    hash = "sha256-+rgtIj4Q+ZL8ENeigmF0dJYzIbJ797A1bOs2mbH4AKI=";
  };

  build-system = [ setuptools ];

  dependencies = [
    google-api-core
    grpc-google-iam-v1
    proto-plus
    protobuf
  ] ++ google-api-core.optional-dependencies.grpc;

  nativeCheckInputs = [
    mock
    pytestCheckHook
    pytest-asyncio
  ];

  pythonImportsCheck = [
    "google.cloud.iam_logging"
    "google.cloud.iam_logging_v1"
  ];

  meta = with lib; {
    description = "IAM Service Logging client library";
    homepage = "https://github.com/googleapis/google-cloud-python/tree/main/packages/google-cloud-iam-logging";
    changelog = "https://github.com/googleapis/google-cloud-python/blob/google-cloud-iam-logging-v${version}/packages/google-cloud-iam-logging/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
