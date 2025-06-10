-- This file defines the spatialid_schema type
CREATE TYPE spatialid_schema AS (
    bbox geometry,                  -- Must be a 3D box (PolygonZ)
    rotation double precision,      -- Rotation in radians
    time_interval double precision, -- Time interval
    time_origin timestamptz         -- Time origin
);
