CREATE TABLE built_feature_ply (
	CONSTRAINT built_feature_ply_pk PRIMARY KEY (gid)
) INHERITS (public.crag);

ALTER TABLE public.CHARACTER VARYING built_feature_ply
ADD CONSTRAINT enforce_geotype_geom
CHECK (geometrytype(geom) = 'POINT'::text);

SELECT populate_geometry_columns('public.built_feature_ply'::regclass);

CREATE UNIQUE INDEX built_feature_ply_pk_idx
ON public.built_feature_ply
USING btree
(gid);
ALTER TABLE public.built_feature_ply CLUSTER ON built_feature_ply_pk_idx;


CREATE INDEX built_feature_ply_sptl_idx
  ON built_feature_ply
  USING gist
  (geom);
COMMENT ON INDEX built_feature_ply_sptl_idx
  IS 'Spatial Index';
