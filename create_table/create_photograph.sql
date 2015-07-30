CREATE TABLE photograph (
	gid BIGSERIAL NOT NULL,
	filename CHARACTER VARYING NOT NULL,
	metadata XML,
	azimuth NUMERIC (5,2),
	subject CHARACTER VARYING,
	date_added DATE,
	geom GEOMETRY(POINT,4326),
	CONSTRAINT photograph_pkey PRIMARY KEY (gid)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE photograph
OWNER TO pocboxdbms;

-- PRIMARY KEY INDEX
CREATE UNIQUE INDEX photograph_pk_idx
ON photograph
USING btree
(gid);
ALTER TABLE photograph CLUSTER ON photograph_pk_idx;

-- SPATIAL INDEX
CREATE INDEX photograph_sptl_idx
ON photograph
USING gist
(geom);