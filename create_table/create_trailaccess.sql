-- Table: trail_access

-- DROP TABLE trail_access;

CREATE TABLE trail_access
(
  gid bigint NOT NULL DEFAULT nextval('trailaccess_gid_seq'::regclass),
  apname character varying,
  accesstype character varying,
  status character varying,
  hasparking boolean,
  accessclass character varying,
  maintainedby character varying,
  datasource character varying,
  dateadded date,
  satellites character varying(3),
  pdop character varying(6),
  satstatus character varying(10),
  hrms character varying(8),
  vrms character varying(8),
  geom geometry(Point,4326),
  globalid uuid,
  CONSTRAINT trailaccess_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trail_access
  OWNER TO pocboxdbms;

-- Index: trailaccess_pk_idx

-- DROP INDEX trailaccess_pk_idx;

CREATE UNIQUE INDEX trailaccess_pk_idx
  ON trail_access
  USING btree
  (gid);
ALTER TABLE trail_access CLUSTER ON trailaccess_pk_idx;

