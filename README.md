# SpatialID Extension

[Spatial ID (空間ID)][1] utilities for PostgreSQL/PostGIS.

## Status

* **Extension version:** 0.1.0
* **Implements:** [空間ID (Spatial ID) specification v1.0][1]

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

3. **Run tests (optional):**

   ```sh
   make test
   ```

## Usage

After installation, in your database:

```sql
CREATE EXTENSION pg_spatialid CASCADE;
```

Read more about the extension's features and usage in the [documentation](docs/index.md).

## Development

* SQL source code is organized in `src/`, with templated files (`.sql.in`) and plain SQL.
* Use `make clean` to remove build artifacts.
* See Makefile for build details.
* For testing, use `make test` to run the included SQL tests (requires `pg_prove`).

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).

[1]: https://www.ipa.go.jp/digital/architecture/guidelines/4dspatio-temporal-guideline.html
