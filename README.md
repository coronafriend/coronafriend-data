# coronafriend-data

Data loading support for CoronaFriend. In time this will be fully scriptable, but for now this is an
aide memoire for the manual commands to get PostgreSQL/PostGIS populated and indexed.

## Data Sources

* [Ordnance Survey Open Roads](https://osdatahub.os.uk/downloads/OpenRoads) - GeoPackage format
* [ONS Postcode Directory](https://geoportal.statistics.gov.uk/datasets/ons-postcode-directory-february-2020) - CSV format

## Prerequisites

* PostgreSQL v12.2 or higher
* PostGIS v3.0.1 or higher
* GDAL v2.4.4 or higher

## Data Loading

```
$ createdb coronafriend
$ psql -U <username> [connection parameters] coronafriend -c 'CREATE EXTENSION postgis;'
```

### Load OS Open Roads

```
$ ogr2ogr -f PostgreSQL PG:"dbname='coronafriend' [connection options]" [/path/to/os-open-roads/oproad_gb.gpkg roadlink -t_srs EPSG:4326 -s_srs EPSG:27700
```

### Load ONS Postcode Directory

```
$ ogr2ogr -f "PostgreSQL" pg:"host=localhost dbname='coronafriend' [connection options]" [/path/to/ons-pd/]ONSPD_FEB_2020_UK/Data/ONSPD_FEB_2020_UK.csv -t_srs EPSG:4326 -s_srs EPSG:4326 -oo X_POSSIBLE_NAMES=long -oo Y_POSSIBLE_NAMES=lat -nln postcodes
```

### Index Creation

```
$ psql -U <username> coronafriend -c 'CREATE INDEX roadlink_roadnametoid_idx ON roadlink(roadnametoid);'
$ psql -U <username> coronafriend -c 'CREATE INDEX postcodes_pcd2_idx ON postcodes(pcd2);'
$ psql -U <username> coronafriend -c 'CREATE INDEX postcodes_pcd2partial_idx ON postcodes(pcd2 varchar_pattern_ops);'
```
