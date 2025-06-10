-- Function to return the global spatial ID schema
CREATE OR REPLACE FUNCTION global_spatialid_schema()
RETURNS spatialid_schema AS $$
  WITH bounds AS (
    SELECT
      6378137.0 * radians(-180.0) AS x_min,
      6378137.0 * radians(180.0) AS x_max,
      6378137.0 * ln(tan(pi()/4 + radians(-85.0511)/2)) AS y_min,
      6378137.0 * ln(tan(pi()/4 + radians(85.0511)/2)) AS y_max
  )
  SELECT ROW(
    make_bbox_polygonz(
      x_min, y_min, -33554432,
      x_max, y_max, 33554432,
      3857
    ),
    0::double precision,
    NULL::double precision,
    NULL::timestamptz
  )::spatialid_schema
  FROM bounds;
$$ LANGUAGE sql IMMUTABLE;
