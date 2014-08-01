#!/usr/bin/env bash
psql -c 'create database test;' -U postgres
psql -U postgres -c "create extension postgis" -d test
cat bytea_import.sql | psql -U postgres -d test
FILE=`readlink -f raster.tif`
echo "$FILE"
echo "SELECT ST_FromGDALRaster(bytea_import('$FILE'), 4326);"
STATEMENT="SELECT ST_FromGDALRaster(bytea_import('$FILE'), 4326);"
echo "$STATEMENT"
psql -U postgres -c "$STATEMENT" -d test
