-- Test for make_bbox_polygonz()
SELECT plan(2);

-- Test 1: Function exists
SELECT has_function('public', 'make_bbox_polygonz', '{double precision,double precision,double precision,double precision,double precision,double precision,integer}', 'Function make_bbox_polygonz(...) should exist');

-- Test 2: Returns expected POLYGON Z for a simple box (compare geometry, not WKT)
SELECT ok(
  ST_Equals(
    make_bbox_polygonz(0, 0, 0, 1, 1, 1, 4326),
    ST_GeomFromText('POLYGON Z((0 0 0,0 1 0,1 1 1,1 0 1,0 0 0))', 4326)
  ),
  'make_bbox_polygonz() returns expected POLYGON Z for (0,0,0)-(1,1,1)'
);

SELECT * FROM finish();
