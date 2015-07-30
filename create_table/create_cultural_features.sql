CREATE TABLE cultural_features (
	gid SERIAL NOT NULL,
	cf_name CHARACTER VARYING,
	cf_type CHARACTER VARYING,
	condition CHARACTER VARYING,
	description CHARACTER VARYING,
	datasource CHARACTER VARYING,
	dateadded DATE,
	geom geometry,
	CONSTRAINT cf_pkey PRIMARY KEY (gid),
	CONSTRAINT cf_enforce_dims_geom CHECK (st_ndims(geom) = 2),
	CONSTRAINT cf_enforce_srid_geom CHECK (st_srid(geom) = 4326)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE cultural_features
OWNER TO pocboxdbms;

--Create Primary Key Index
CREATE UNIQUE INDEX cf_pk_idx
ON cultural_features
USING btree
(gid);
ALTER TABLE cultural_features CLUSTER ON cf_pk_idx;

--CREATE SPATIAL INDEX
CREATE INDEX cf_sptl_idx
ON cultural_features
USING gist
(geom);
COMMENT ON INDEX cf_sptl_idx
IS 'Spatial Index';

-- CREATE CULTURAL FEATURES POINT CHILD TABLE
CREATE TABLE cultural_features_pnt (
	CONSTRAINT cf_pnt_pk PRIMARY KEY (gid)
) INHERITS (public.cultural_features);

ALTER TABLE cultural_features_pnt
ADD CONSTRAINT cf_pnt_enforce_geotype_geom
CHECK (geometrytype(geom) = 'POINT'::text);

-- REGISTER CULTURAL FEATURES POINT CHILD TABLE WITH GEOMETRY COLUMNS
SELECT populate_geometry_columns('public.cultural_features_pnt'::regclass);

-- CREATE PRIMARY KEY INDEX
CREATE UNIQUE INDEX cf_pnt_pk_idx
ON cultural_features_pnt
USING btree
(gid);
ALTER TABLE public.cultural_features_pnt CLUSTER ON cf_pnt_pk_idx;

-- CREATE SPATIAL INDEX
CREATE INDEX cf_pnt_sptl_idx
ON cultural_features_pnt
USING gist
(geom);
COMMENT ON INDEX cf_pnt_sptl_idx
IS 'Spatial Index';

-- CREATE CULTURAL FEATURES LINE CHILD TABLE
CREATE TABLE cultural_features_lne (
	CONSTRAINT cf_lne_pk PRIMARY KEY (gid)
) INHERITS (public.cultural_features);

ALTER TABLE cultural_features_lne 
ADD CONSTRAINT cf_lne_enforce_geotype_geom
CHECK (geometrytype(geom) = 'MULTILINESTRING'::text);

-- REGISTER CULTURAL FEATURES LINE CHILD TABLE WITH GEOMETRY COLUMNS
SELECT populate_geometry_columns('public.cultural_features_lne'::regclass);

-- CREATE PRIMARY KEY INDEX
CREATE UNIQUE INDEX cf_lne_pk_idx
ON cultural_features_lne
USING btree
(gid);
ALTER TABLE public.cultural_features_lne CLUSTER ON cf_lne_pk_idx;

-- CREATE SPATIAL INDEX
CREATE INDEX cf_lne_sptl_idx
ON cultural_features_lne
USING gist
(geom);
COMMENT ON INDEX cf_lne_sptl_idx
IS 'Spatial Index';

-- CREATE CULTURAL FEATURES POLYGON CHILD TABLE
CREATE TABLE cultural_Features_ply (
	CONSTRAINT cf_ply_pk PRIMARY KEY (gid)
) INHERITS (public.cultural_features);

ALTER TABLE cultural_features_ply
ADD CONSTRAINT cf_ply_enforce_geotype_geom
CHECK (geometrytype(geom) = 'MULTIPOLYGON'::text);

-- REGISTER CULTURAL FEATURES POLYGON CHILD TABLE WITH GEOMETRY COLUMNS
SELECT populate_geometry_columns('public.cultural_features_ply'::regclass);

-- CREATE PRIMARY KEY INDEX
CREATE UNIQUE INDEX cf_ply_pk_idx
ON cultural_features_ply
USING btree
(gid);
ALTER TABLE public.cultural_features_ply CLUSTER ON cf_ply_pk_idx;

-- CREATE SPATIAL INDEX
CREATE INDEX cf_ply_sptl_idx
ON cultural_features_ply 
USING gist
(geom);
COMMENT ON INDEX cf_ply_sptl_idx
IS 'Spatial Index';