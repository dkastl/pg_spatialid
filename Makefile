EXT_VERSION := $(shell cat VERSION)
EXTENSION := pg_spatialid
PG_CONFIG := pg_config

# Collect all .sql.in and .sql in types and functions folders
TYPES_SQL_IN := $(wildcard src/types/*.sql.in)
TYPES_SQL := $(wildcard src/types/*.sql)
FUNCTIONS_SQL_IN := $(wildcard src/functions/*.sql.in)
FUNCTIONS_SQL := $(wildcard src/functions/*.sql)

# Build/processed targets
TYPES_BUILD_FROM_IN := $(patsubst src/types/%.sql.in,build/types/%.sql,$(TYPES_SQL_IN))
TYPES_BUILD_FROM_SQL := $(patsubst src/types/%.sql,build/types/%.sql,$(TYPES_SQL))
FUNCTIONS_BUILD_FROM_IN := $(patsubst src/functions/%.sql.in,build/functions/%.sql,$(FUNCTIONS_SQL_IN))
FUNCTIONS_BUILD_FROM_SQL := $(patsubst src/functions/%.sql,build/functions/%.sql,$(FUNCTIONS_SQL))

TYPES_BUILD := $(TYPES_BUILD_FROM_IN) $(TYPES_BUILD_FROM_SQL)
FUNCTIONS_BUILD := $(FUNCTIONS_BUILD_FROM_IN) $(FUNCTIONS_BUILD_FROM_SQL)
SQL_SOURCES := $(TYPES_BUILD) $(FUNCTIONS_BUILD)

# The built SQL file for packaging/install (must be in root for PGXS)
BUILT_SQL := pg_spatialid--$(EXT_VERSION).sql

.PHONY: all build install uninstall clean print-sources

all: build

print-sources:
	@echo "Types .sql.in: $(TYPES_SQL_IN)"
	@echo "Types .sql:    $(TYPES_SQL)"
	@echo "Functions .sql.in: $(FUNCTIONS_SQL_IN)"
	@echo "Functions .sql:    $(FUNCTIONS_SQL)"
	@echo "SQL_SOURCES: $(SQL_SOURCES)"

# Ensure build subdirs exist before generating files
build/types:
	mkdir -p build/types

build/functions:
	mkdir -p build/functions

# .sql.in -> build with version substitution
build/types/%.sql: src/types/%.sql.in | build/types
	sed "s/@EXT_VERSION@/$(EXT_VERSION)/g" $< > $@

build/functions/%.sql: src/functions/%.sql.in | build/functions
	sed "s/@EXT_VERSION@/$(EXT_VERSION)/g" $< > $@

# .sql -> build (direct copy)
build/types/%.sql: src/types/%.sql | build/types
	cp $< $@

build/functions/%.sql: src/functions/%.sql | build/functions
	cp $< $@

# Build target: concatenate types first, then functions, with newlines
build: $(BUILT_SQL)

$(BUILT_SQL): $(SQL_SOURCES) VERSION
	@echo "Concatenating SQL sources into $@"
	for f in $(TYPES_BUILD); do cat $$f; echo ""; done > $@; \
	for f in $(FUNCTIONS_BUILD); do cat $$f; echo ""; done >> $@
	@echo "Built $@"

# Use standard PGXS install; no need to call make -f $(PGXS) directly
DATA = $(BUILT_SQL)
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

clean:
	rm -rf build $(BUILT_SQL)
