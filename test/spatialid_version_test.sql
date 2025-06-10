-- Test for spatialid_version function
-- This test file checks that the spatialid_version function exists and returns the correct version as specified in the VERSION file.

-- Read the extension version from the VERSION file into a psql variable
\set ext_version `cat ../VERSION`

-- Plan for 2 tests: function existence and correct version return
SELECT plan(2);

-- Test 1: Check that the spatialid_version() function exists in the public schema with no arguments
SELECT has_function('public', 'spatialid_version', '{}', 'Function spatialid_version() should exist');

-- Test 2: Check that spatialid_version() returns the correct extension version (from VERSION file)
SELECT results_eq(
  'SELECT extension_version FROM spatialid_version()',
  ARRAY[:'ext_version'],
  'spatialid_version() returns the correct extension version'
);

-- Finish the test and output results
SELECT * FROM finish();
