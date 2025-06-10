-- Test for global_spatialid_schema()
SELECT plan(2);

-- Test 1: Function exists
SELECT has_function('public', 'global_spatialid_schema', '{}', 'Function global_spatialid_schema() should exist');

-- Test 2: Returns expected bbox (spec-derived check)
SELECT results_eq(
  $$
  SELECT
    round(ST_XMin(bbox)::numeric, 6) = round(-20037508.3427892::numeric, 6) AND
    round(ST_YMin(bbox)::numeric, 6) = round(-20037471.2051371::numeric, 6) AND
    ST_ZMin(bbox)::numeric           = -33554432::numeric AND
    round(ST_XMax(bbox)::numeric, 6) = round(20037508.3427892::numeric, 6) AND
    round(ST_YMax(bbox)::numeric, 6) = round(20037471.2051371::numeric, 6) AND
    ST_ZMax(bbox)::numeric           = 33554432::numeric
  FROM global_spatialid_schema()
  $$,
  ARRAY[true],
  'global_spatialid_schema() returns spec-derived bbox (rounded)'
);

SELECT * FROM finish();
