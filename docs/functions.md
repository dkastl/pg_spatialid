# Functions Documentation

## spatialid_version()

Returns the extension and spec version information as a `spatialid_version_info` composite type.

**Returns:**

- `spatialid_version_info`: Composite type with `extension_version` and `spec_version` fields.

**Example:**

```sql
SELECT * FROM spatialid_version();

-- Returns:
--    extension_version | spec_version
-- ---------------------+--------------
--         0.1.0        |   1.0.0
```

## global_spatialid_schema()

Returns a `spatialid_schema` describing the global 空間ID grid system based on the official specification (covering the entire world and height range).

**Returns:**

- `spatialid_schema`: With bbox as a 3D Web Mercator envelope covering:

  - X: -20037508.342789244 to +20037508.342789244 (meters)
  - Y: -20037508.342789244 to +20037508.342789244 (meters)
  - Z: -33554432 to +33554432 (meters)

  Rotation is 0, and time fields are `NULL`.

**Example:**

```sql
SELECT
  bbox::box3d AS box3d,
  rotation,
  time_interval,
  time_origin
FROM global_spatialid_schema();

-- Returns:
--      box3d    | rotation | time_interval | time_origin
-- --------------+----------+---------------+------------
-- BOX3D(...)    |   0      |     NULL      |   NULL
```

## local_spatialid_schema()

Creates a custom local 空間ID grid schema as a `spatialid_schema` from a specified origin point and extents. The CRS/units are taken from the input geometry.

**Parameters:**

- `origin` (`geometry`): The lower-left (or bottom) corner of the grid, including SRID and (optionally) Z value.
- `extent_x` (`double precision`, default 100): Size of the X (width) dimension in units of the CRS.
- `extent_y` (`double precision`, default 100): Size of the Y (length) dimension in units of the CRS.
- `extent_z` (`double precision`, default NULL): Optional, size of the Z (height) dimension in units of the CRS.
- `rotation` (`double precision`, default 0): Grid rotation in radians.
- `time_interval` (`double precision`, default NULL): Optional, time slice duration.
- `time_origin` (`timestamptz`, default NULL): Optional, time reference origin.

**Returns:**

- `spatialid_schema`: Composite type with the bounding box (`bbox`), rotation, and time fields.

**Notes:**

- All extent values use the same units as the CRS of `origin`.
- If `extent_z` is `NULL`, the bounding box will be 2D (Z of both corners will be the same).
- The SRID is inherited from the input geometry.

**Example:**

```sql
SELECT
  bbox::box3d AS box3d,
  rotation,
  time_interval,
  time_origin
FROM local_spatialid_schema(
  ST_MakePoint(135, 34, 0)::geometry(PointZ, 4326),
  0.01, 0.01, 0.001
);

-- Returns:
--    box3d      | rotation | time_interval | time_origin
-- --------------+----------+---------------+------------
-- BOX3D(...)    |   0      |     NULL      |   NULL
```

## make_bbox_polygonz

Creates a `POLYGON Z` geometry representing the rectangular base (bottom face) of a 3D bounding box, using two opposite corners and an SRID.

**Parameters:**

- `x_min`, `y_min`, `z_min` (`double precision`): Coordinates of the minimum corner.
- `x_max`, `y_max`, `z_max` (`double precision`): Coordinates of the maximum corner.
- `srid` (`integer`): The SRID for the resulting geometry.

**Returns:**

A `POLYGON Z` geometry (with the given SRID) representing a rectangle in 3D space.

**Example:**

```sql
SELECT ST_AsText(
  make_bbox_polygonz(0, 0, 0, 1, 1, 1, 4326)
);

-- Returns: POLYGON Z ((0 0 0,0 1 0,1 1 1,1 0 1,0 0 0))
```
