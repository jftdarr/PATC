-- Table: trail_crossing

-- DROP TABLE trail_crossing;

CREATE TABLE trail_crossing
(
  gid BIGSERIAL NOT NULL,
  tnname CHARACTER VARYING,
  tnsname CHARACTER VARYING,
  structure_name CHARACTER VARYING,
  crossing_type CHARACTER VARYING,
  crosses CHARACTER VARYING,
  designed_use CHARACTER VARYING,
  construction CHARACTER VARYING,
  condition CHARACTER VARYING,
  structure_class SMALLINT,
  width_class SMALLINT,
  treadtc SMALLINT,
  obstacletc SMALLINT,
  maintained_by CHARACTER VARYING,
  date_added DATE,
  data_source CHARACTER VARYING,
  geom GEOMETRY(MultiLineString,4326),
  CONSTRAINT trail_crossing_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trail_crossing
  OWNER TO patcdbms;

-- Index: trail_crossing_pk_idx

-- DROP INDEX trail_crossing_pk_idx;

CREATE UNIQUE INDEX trail_crossing_pk_idx
  ON trail_crossing
  USING btree
  (gid);
ALTER TABLE trail_crossing CLUSTER ON trail_crossing_pk_idx;

-- Index: trail_crossing_sptl_idx

-- DROP INDEX trail_crossing_sptl_idx;

CREATE INDEX trail_crossing_sptl_idx
  ON trail_crossing
  USING gist
  (geom);
COMMENT ON INDEX trail_crossing_sptl_idx
  IS 'Spatial Index';
