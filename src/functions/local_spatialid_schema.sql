-- Function to create a local spatialid_schema from an origin point and extents
CREATE OR REPLACE FUNCTION local_spatialid_schema(
    origin geometry,                                -- Required: lower-left/bottom corner (with SRID/units)
    extent_x double precision DEFAULT 100,          -- Default X extent (same units as CRS)
    extent_y double precision DEFAULT 100,          -- Default Y extent (same units as CRS)
    extent_z double precision DEFAULT NULL,         -- Optional: height (same units as CRS)
    rotation double precision DEFAULT 0,            -- Default: 0 radians
    time_interval double precision DEFAULT NULL,    -- Default: NULL (no time)
    time_origin timestamptz DEFAULT NULL            -- Default: NULL (no time)
)
RETURNS spatialid_schema AS $$
DECLARE
    x double precision := ST_X(origin);
    y double precision := ST_Y(origin);
    z double precision := COALESCE(ST_Z(origin), 0);
    srid integer := ST_SRID(origin);
    bbox geometry;
    zmax double precision;
BEGIN
    IF extent_z IS NOT NULL THEN
        zmax := z + extent_z;
    ELSE
        zmax := z;
    END IF;
    bbox := make_bbox_polygonz(
                x, y, z,
                x + extent_x, y + extent_y, zmax,
                srid
            );
    RETURN ROW(bbox, rotation, time_interval, time_origin)::spatialid_schema;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
