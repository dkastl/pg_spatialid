# Types Documentation

## spatialid_version_info

A composite type that holds versioning information for the extension and the spatial identifier specification.

**Fields:**

- `extension_version` (`text`): The extension version.
- `spec_version` (`text`): The specification version.


## spatialid_schema

A composite type describing the spatial schema (extent, rotation, and time basis) for 空間ID/SpatialID grid systems.

**Fields:**

- `bbox` (`geometry`): The 3D bounding box (PolygonZ or envelope). Must include all spatial extents and can be created in any supported CRS (coordinate reference system). The bounding box is typically created by `ST_Envelope` of two 3D points.
- `rotation` (`double precision`): Rotation in radians. Describes the grid orientation relative to the CRS axis.
- `time_interval` (`double precision`): Duration (in seconds, or CRS units for time) of each temporal "slice" of the grid, or `NULL` if not used.
- `time_origin` (`timestamptz`): The reference origin for the time dimension, or `NULL` if not used.

**Notes:**

- The `bbox` must be a valid 3D geometry (PolygonZ or envelope). The SRID and units must be managed by the user as appropriate for their use case.
- For most applications, the global schema uses Web Mercator (SRID: 3857, units: meters), but other projections are supported for local grids.
- The default time interval is `NULL` (no time segmentation).

**Example:**

```sql
SELECT * FROM global_spatialid_schema();
```
