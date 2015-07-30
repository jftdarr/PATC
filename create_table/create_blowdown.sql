CREATE TABLE blowdown (
	gid SERIAL NOT NULL,
	max_diameter SMALLINT,
	tree_section CHARACTER VARYING,
	tree_count SMALLINT,
	observations TEXT,
	blowdown_status CHARACTER VARYING,
	date_found DATE,
	date_cleared DATE,
	clearance_response CHARACTER VARYING,
	geom geometry(POINT,4326),
	CONSTRAINT blowdown_pkey PRIMARY KEY (gid)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE blowdown
OWNER TO pactdbms;

-- PRIMARY KEY INDEX
CREATE UNIQUE INDEX blowdown_pk_idx
ON blowdown
USING btree
(gid);
ALTER TABLE blowdown cluster on blowdown_pk_idx;


-- SPATIAL INDEX
CREATE INDEX blowdown_sptl_idx
ON blowdown
USING gist
(geom);
