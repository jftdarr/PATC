CREATE TABLE built_feature_lne (
	CONSTRAINT built_feature_lne_pk PRIMARY KEY (gid)
) INHERITS (public.crag);

ALTER TABLE public.CHARACTER VARYING built_feature_lne
ADD CONSTRAINT enforce_geotype_geom
CHECK (geometrytype(geom) = 'MULTILINESTRING'::text);

SELECT populate_geometry_columns('public.built_feature_lne'::regclass);

CREATE UNIQUE INDEX built_feature_lne_pk_idx
ON public.built_feature_lne
USING btree
(gid);
ALTER TABLE public.built_feature_lne CLUSTER ON built_feature_lne_pk_idx;


CREATE INDEX built_feature_lne_sptl_idx
  ON built_feature_lne
  USING gist
  (geom);
COMMENT ON INDEX built_feature_lne_sptl_idx
  IS 'Spatial Index';
