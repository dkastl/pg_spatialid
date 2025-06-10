-- Helper to construct a PolygonZ bbox from two corners (min and max)
CREATE OR REPLACE FUNCTION make_bbox_polygonz(
    x_min double precision, y_min double precision, z_min double precision,
    x_max double precision, y_max double precision, z_max double precision,
    srid integer
) RETURNS geometry AS $$
BEGIN
    RETURN ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(x_min, y_min, z_min),
                ST_MakePoint(x_min, y_max, z_min),
                ST_MakePoint(x_max, y_max, z_max),
                ST_MakePoint(x_max, y_min, z_max),
                ST_MakePoint(x_min, y_min, z_min)
            ])
        ), srid
    );
END;
$$ LANGUAGE plpgsql IMMUTABLE;
