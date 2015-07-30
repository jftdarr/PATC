CREATE TABLE blowdown_has_photograph (
	gid SERIAL NOT NULL,
  blowdown_key INT NOT NULL,
  photo_filename CHARACTER VARYING,
	CONSTRAINT blowdown_has_photograph_pkey PRIMARY KEY (gid),
  CONSTRAINT blowdown_has_photograph_fkey FOREIGN KEY (blowdown_key)
      REFERENCES blowdown(gid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
	OIDS=FALSE
);
ALTER TABLE blowdown_has_photograph
OWNER TO pactdbms;

-- PRIMARY KEY INDEX
CREATE UNIQUE INDEX blowdown_has_photograph_pk_idx
ON blowdown_has_photograph
USING btree
(gid);
ALTER TABLE blowdown_has_photograph cluster on blowdown_has_photograph_pk_idx;


-- Index: blowdown_has_photograph_fk_idx

-- DROP INDEX blowdown_has_photograph_fk_idx;

CREATE INDEX blowdown_has_photograph_fk_idx
  ON blowdown_has_photograph
  USING btree
  (blowdown_key);


-- SPATIAL INDEX
CREATE INDEX blowdown_has_photograph_sptl_idx
ON blowdown_has_photograph
USING gist
(geom);
