#!/usr/bin/env bash
psql -U postgres -c "drop database if exists test;"
psql -U postgres -c 'create database test;'
psql -U postgres -d test -c "create extension postgis"
psql -U postgres -d test -f bytea_import.sql
FILE=`readlink -f raster.tif`
echo "$FILE"
STATEMENT="SELECT ST_FromGDALRaster(bytea_import('$FILE'), 4326);"
echo "$STATEMENT"
psql -U postgres -d test -c "$STATEMENT"
EXIT=$?
echo "EXIT CODE: $EXIT"
exit $EXIT