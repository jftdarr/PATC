-- Table: built_trail

-- DROP TABLE built_trail;

CREATE TABLE built_trail
(
  gid BIGSERIAL NOT NULL,
  tnname CHARACTER VARYING,
  tnsname CHARACTER VARYING,
  trail_type CHARACTER VARYING,
  access_class CHARACTER VARYING,
  heirarchy CHARACTER VARYING,
  construction CHARACTER VARYING,
  condition CHARACTER VARYING,
  visibility CHARACTER VARYING,
  trail_class SMALLINT,
  treadtc SMALLINT,
  obstacletc SMALLINT,
  difficulty_grade SMALLINT,
  width_class SMALLINT,
  designed_use CHARACTER VARYING,
  foot_permitted CHARACTER VARYING,
  bicycle_permitted CHARACTER VARYING,
  packsaddle_permitted CHARACTER VARYING,
  vehicle_permitted CHARACTER VARYING,
  pets_permitted CHARACTER VARYING,
  maintained_by CHARACTER VARYING,
  data_source CHARACTER VARYING,
  date_added DATE,
  geom geometry(MultiLineString,4326),
  CONSTRAINT built_trail_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE built_trail
  OWNER TO patcdbms;

-- Index: built_trail_pk_idx

-- DROP INDEX built_trail_pk_idx;

CREATE UNIQUE INDEX built_trail_pk_idx
  ON built_trail
  USING btree
  (gid);
ALTER TABLE built_trail CLUSTER ON built_trail_pk_idx;

-- Index: built_trail_sptl_idx

-- DROP INDEX built_trail_sptl_idx;

CREATE INDEX built_trail_sptl_idx
  ON built_trail
  USING gist
  (geom);
COMMENT ON INDEX built_trail_sptl_idx
  IS 'Spatial Index';
