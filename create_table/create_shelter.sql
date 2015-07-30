CREATE TABLE shelter (
	gid SERIAL PRIMARY KEY,
	name CHARACTER VARYING,
	type CHARACTER VARYING,
	class CHARACTER VARYING,
	status CHARACTER VARYING,
	condition CHARACTER VARYING,
	reservationreq CHARACTER VARYING,
	construction CHARACTER VARYING,
	roofconstruction CHARACTER VARYING,
	floorarea NUMERIC(9,4),
	capacity SMALLINT,
	amenities TEXT[],
	description TEXT,
	datasource CHARACTER VARYING,
	dateadded DATE,
	geom geometry,
	CONSTRAINT shelter_pkey PRIMARY KEY (gid),
	CONSTRAINT shelter_enforce_dims_geom CHECK (st_ndims(geom) = 2),
	CONSTRAINT shelter_enforce_srid_geom CHECK (st_srid(geom) = 4326)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE shelter
OWNER TO pocboxdbms;

-- Create Primary Key Index
CREATE UNIQUE INDEX shelter_pk_idx
ON shelter
USING btree
(gid);
ALTER TABLE shelter CLUSTER ON shelter_pk_idx;

-- Create Spatial Index
CREATE INDEX shelter_sptl_idx
ON shelter
USING gist
(geom);
COMMENT ON INDEX shelter_sptl_idx
IS 'Spatial Index';

--Create Shelter Point Child Table
CREATE TABLE shelter_pnt (
	CONSTRAINT shelter_pnt_pk PRIMARY KEY (gid)
) INHERITS (public.shelter);

ALTER TABLE public.shelter_pnt
ADD CONSTRAINT enforce_geotype_geom
CHECK (geometrytype(geom) = 'POINT'::text);

SELECT populate_geometry_columns('public.shelter_pnt'::regclass);

-- Create Primary Key Index
CREATE UNIQUE INDEX shelter_pnt_pk_idx
ON public.shelter_pnt
USING btree
(gid);
ALTER TABLE public.shelter_pnt CLUSTER ON shelter_pnt_pk_idx;

-- Create Spatial Index
CREATE INDEX shelter_pnt_sptl_idx
ON shelter_pnt
USING gist
(geom);
COMMENT ON INDEX shelter_pnt_sptl_idx
IS 'Spatial Index';

--Create Shelter Polygon Child Table
CREATE TABLE shelter_ply (
	CONSTRAINT shelter_ply_pk PRIMARY KEY (gid)
) INHERITS (public.shelter);

ALTER TABLE public.shelter_ply
ADD CONSTRAINT enforce_geotype_geom
CHECK (geometrytype(geom) = 'MULTIPOLYGON'::text);

SELECT populate_geometry_columns('public.shelter_ply'::regclass);

-- Create Primary Key Index
CREATE UNIQUE INDEX shelter_ply_pk_idx
ON public.shelter_ply
USING btree
(gid);
ALTER TABLE public.shelter_ply CLUSTER ON shelter_ply_pk_idx;

-- Create Spatial Index
CREATE INDEX shelter_ply_sptl_idx
ON shelter_ply
USING gist
(geom);
COMMENT ON INDEX shelter_ply_sptl_idx
IS 'Spatial Index';