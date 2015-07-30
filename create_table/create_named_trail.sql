-- Table: named_trail

-- DROP TABLE named_trail;

CREATE TABLE named_trail
(
  gid serial NOT NULL,
  tnname character varying,
  tnsname character varying,
  heirarchy character varying,
  blazecolor character varying,
  geom geometry(MultiLineString,4326),
  CONSTRAINT named_trail_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE named_trail
  OWNER TO pocboxdbms;

-- Index: named_trail_pk_idx

-- DROP INDEX named_trail_pk_idx;

CREATE UNIQUE INDEX named_trail_pk_idx
  ON named_trail
  USING btree
  (gid);
ALTER TABLE named_trail CLUSTER ON named_trail_pk_idx;

-- Index: named_trail_sptl_idx

-- DROP INDEX named_trail_sptl_idx;

CREATE INDEX named_trail_sptl_idx
  ON named_trail
  USING gist
  (geom);
COMMENT ON INDEX named_trail_sptl_idx
  IS 'Spatial Index';

