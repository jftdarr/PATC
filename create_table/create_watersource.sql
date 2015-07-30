CREATE TABLE water_source (
	gid SERIAL NOT NULL,
	ws_name CHARACTER VARYING,
	classification CHARACTER VARYING,
	condition CHARACTER VARYING,
	description CHARACTER VARYING,
	datasource CHARACTER VARYING,
	dateadded DATE,
	geom geometry,
	CONSTRAINT ws_pkey PRIMARY KEY (gid),
	CONSTRAINT ws_enforce_dims_geom CHECK (st_ndims(geom) = 2),
	CONSTRAINT ws_enforce_srid_geom CHECK (st_srid(geom) = 4326)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE water_source
OWNER TO pocboxdbms;

--Create Primary Key Index
CREATE UNIQUE INDEX ws_pk_idx
ON water_source
USING btree
(gid);
ALTER TABLE water_source CLUSTER ON ws_pk_idx;

--CREATE SPATIAL INDEX
CREATE INDEX ws_sptl_idx
ON water_source
USING gist
(geom);
COMMENT ON INDEX ws_sptl_idx
IS 'Spatial Index';

-- CREATE WATER SOURCE POINT CHILD TABLE
CREATE TABLE water_source_pnt (
	CONSTRAINT ws_pnt_pk PRIMARY KEY (gid)
) INHERITS (public.water_source);

ALTER TABLE water_source_pnt
ADD CONSTRAINT ws_pnt_enforce_geotype_geom
CHECK (geometrytype(geom) = 'POINT'::text);

-- REGISTER WATER SOURCE POINT CHILD TABLE WITH GEOMETRY COLUMNS
SELECT populate_geometry_columns('public.water_source_pnt'::regclass);

-- CREATE PRIMARY KEY INDEX
CREATE UNIQUE INDEX ws_pnt_pk_idx
ON water_source_pnt
USING btree
(gid);
ALTER TABLE public.water_source_pnt CLUSTER ON ws_pnt_pk_idx;

-- CREATE SPATIAL INDEX
CREATE INDEX ws_pnt_sptl_idx
ON water_source_pnt
USING gist
(geom);
COMMENT ON INDEX ws_pnt_sptl_idx
IS 'Spatial Index';

-- CREATE WATER SOURCE LINE CHILD TABLE
CREATE TABLE water_source_lne (
	CONSTRAINT ws_lne_pk PRIMARY KEY (gid)
) INHERITS (public.water_source);

ALTER TABLE water_source_lne 
ADD CONSTRAINT ws_lne_enforce_geotype_geom
CHECK (geometrytype(geom) = 'MULTILINESTRING'::text);

-- REGISTER WATER SOURCE LINE CHILD TABLE WITH GEOMETRY COLUMNS
SELECT populate_geometry_columns('public.water_source_lne'::regclass);

-- CREATE PRIMARY KEY INDEX
CREATE UNIQUE INDEX ws_lne_pk_idx
ON water_source_lne
USING btree
(gid);
ALTER TABLE public.water_source_lne CLUSTER ON ws_lne_pk_idx;

-- CREATE SPATIAL INDEX
CREATE INDEX ws_lne_sptl_idx
ON water_source_lne
USING gist
(geom);
COMMENT ON INDEX ws_lne_sptl_idx
IS 'Spatial Index';