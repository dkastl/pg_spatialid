-- Test for local_spatialid_schema()
SELECT plan(2);

-- Test 1: Function exists
SELECT has_function('public', 'local_spatialid_schema', '{geometry,double precision,double precision,double precision,double precision,double precision,timestamptz}', 'Function local_spatialid_schema(geometry, double precision, double precision, double precision, double precision, double precision, timestamptz) should exist');

-- Test 2: Returns expected bbox for a simple case
SELECT results_eq(
  $$SELECT
      ST_XMin(bbox)::numeric=135 AND
      ST_YMin(bbox)::numeric=34 AND
      ST_ZMin(bbox)::numeric=0 AND
      ST_XMax(bbox)::numeric=135.01 AND
      ST_YMax(bbox)::numeric=34.01 AND
      ST_ZMax(bbox)::numeric=0.001
    FROM local_spatialid_schema(
      ST_MakePoint(135, 34, 0)::geometry(PointZ, 4326),
      0.01, 0.01, 0.001, 0, NULL, NULL)$$,
  ARRAY[true],
  'local_spatialid_schema() returns expected bbox min/max coordinates for simple input'
);

SELECT * FROM finish();
