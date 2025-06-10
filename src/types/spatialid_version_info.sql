-- Custom type for version info
CREATE TYPE spatialid_version_info AS (
  extension_version text,
  spec_version text
);

COMMENT ON TYPE spatialid_version_info IS
'Composite type holding extension_version and spec_version for the spatialid extension.';
