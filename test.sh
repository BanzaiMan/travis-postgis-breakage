#!/usr/bin/env bash
psql -c 'create database test;' -U postgres
psql -U postgres -c "create extension postgis" -d test
cat bytea_import.sql | psql -U postgres -d test
FILE=${readlink -f raster.tif}
psql -U postgres -c "SELECT ST_FromGDALRaster(bytea_import('$FILE'), 4326);" -d test