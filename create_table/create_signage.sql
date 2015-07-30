CREATE TABLE signage (
	gid BIGSERIAL PRIMARY KEY,
	sign_type CHARACTER VARYING (15),
	blazecolor CHARACTER VARYING (25),
	condition CHARACTER VARYING,
	mileagedist NUMERIC(7,2),
	attribution TEXT[],
	description CHARACTER VARYING,
	datasource CHARACTER VARYING,
	dateadded DATE,
	geom GEOMETRY(POINT,4326)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE public.signage
OWNER TO pocboxdbms;

--CREATE PRIMARY KEY INDEX
CREATE UNIQUE INDEX signage_pk_idx
ON public.signage
USING btree
(gid);
ALTER TABLE public.signage CLUSTER ON signage_pk_idx;

-- CREATE SPATIAL INDEX
CREATE INDEX signage_sptl_idx
ON public.signage
USING gist
(geom);