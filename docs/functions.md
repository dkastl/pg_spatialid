# Functions Documentation

## spatialid_version()

Returns the extension and spec version information as a `spatialid_version_info` composite type.

**Returns:**

- `spatialid_version_info`: Composite type with `extension_version` and `spec_version` fields.

**Example:**

```sql
SELECT * FROM spatialid_version();

-- Returns: extension_version | spec_version
--                   0.1.0    |   1.0.0
```
