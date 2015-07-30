-- Table: trail_steps

-- DROP TABLE trail_steps;

CREATE TABLE trail_steps
(
  gid bigserial NOT NULL,
  tname CHARACTER VARYING,
  tnsname CHARACTER VARYING,
  structure_name CHARACTER VARYING,
  designed_use CHARACTER VARYING,
  construction CHARACTER VARYING,
  condition CHARACTER VARYING,
  structure_class SMALLINT,
  width_class SMALLINT,
  treadtc SMALLINT,
  obstacletc SMALLINT,
  railing_present CHARACTER VARYING,
  maintained_by CHARACTER VARYING,
  date_added DATE,
  data_source CHARACTER VARYING,
  geom GEOMETRY(MultiLineString,4326),
  CONSTRAINT trail_steps_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trail_steps
  OWNER TO patcdbms;

-- Index: trail_steps_pk_idx

-- DROP INDEX trail_steps_pk_idx;

CREATE UNIQUE INDEX trail_steps_pk_idx
  ON trail_steps
  USING btree
  (gid);
ALTER TABLE trail_steps CLUSTER ON trail_steps_pk_idx;

-- Index: trail_steps_sptl_idx

-- DROP INDEX trail_steps_sptl_idx;

CREATE INDEX trail_steps_sptl_idx
  ON trail_steps
  USING gist
  (geom);
COMMENT ON INDEX trail_steps_sptl_idx
  IS 'Spatial Index';
