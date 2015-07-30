-- Table: built_feature

-- DROP TABLE built_feature;

CREATE TABLE built_feature
(
  gid serial NOT NULL,
  bf_name CHARACTER VARYING,
  bf_type CHARACTER VARYING,
  condition CHARACTER VARYING,
  description CHARACTER VARYING,
  data_source CHARACTER VARYING,
  date_added DATE,
  geom GEOMETRY,
  CONSTRAINT bf_pkey PRIMARY KEY (gid),
  CONSTRAINT bf_enforce_dims_geom CHECK (st_ndims(geom) = 2),
  CONSTRAINT bf_enforce_srid_geom CHECK (st_srid(geom) = 4326)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE built_feature
  OWNER TO patcdbms;

-- Index: bf_pk_idx

-- DROP INDEX bf_pk_idx;

CREATE UNIQUE INDEX built_feature_pk_idx
  ON built_feature
  USING btree
  (gid);
ALTER TABLE built_feature CLUSTER ON built_feature_pk_idx;
COMMENT ON INDEX built_feature_pk_idx IS 'Primary key clustered index'

-- Index: bf_sptl_idx

-- DROP INDEX bf_sptl_idx;

CREATE INDEX built_feature_sptl_idx
  ON built_feature
  USING gist
  (geom);
COMMENT ON INDEX built_feature_sptl_idx
  IS 'Spatial Index';
