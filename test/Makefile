# pg_spatialid test runner for pgTAP
# Usage: make test

PGUSER ?= postgres
PGDATABASE ?= pg_spatialid_test
PGPORT ?= 5432
PGHOST ?= localhost

TESTDIR := test
TESTS := $(wildcard *.sql)

.PHONY: test createdb dropdb

test: createdb
	@echo "Running pgTAP tests..."
	@pg_prove -U $(PGUSER) -d $(PGDATABASE) $(TESTS)

dropdb:
	-dropdb -h $(PGHOST) -p $(PGPORT) -U $(PGUSER) $(PGDATABASE)

createdb: dropdb
	createdb -h $(PGHOST) -p $(PGPORT) -U $(PGUSER) $(PGDATABASE)
	psql -h $(PGHOST) -p $(PGPORT) -U $(PGUSER) -d $(PGDATABASE) -c 'CREATE EXTENSION IF NOT EXISTS pgtap;'
	psql -h $(PGHOST) -p $(PGPORT) -U $(PGUSER) -d $(PGDATABASE) -c 'CREATE EXTENSION IF NOT EXISTS pg_spatialid CASCADE;'
