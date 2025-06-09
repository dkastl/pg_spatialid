# SpatialID Extension

Spatial ID (空間ID) utilities for PostgreSQL/PostGIS.

## Status

* **Extension version:** 0.1.0
* **Implements:** 空間ID (Spatial ID) specification v1.0

## Requirements

* PostgreSQL >= TBD
* PostGIS >= TBD
* GNU Make

## Installation

1. **Build the extension:**

   ```sh
   make build
   ```

2. **Install to PostgreSQL (may require sudo):**

   ```sh
   sudo make install
   ```

## Usage

After installation, in your database:

```sql
CREATE EXTENSION pg_spatialid CASCADE;
```

### Example: Show extension version

```sql
SELECT * FROM spatialid_version();
-- Returns: extension_version | spec_version
--                   0.1.0    |   1.0.0
```

## Development

* SQL source code is organized in `src/`, with templated files (`.sql.in`) and plain SQL.
* Use `make clean` to remove build artifacts.
* See Makefile for build details.

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
