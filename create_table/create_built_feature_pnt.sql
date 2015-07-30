CREATE TABLE built_feature_pnt (
	CONSTRAINT built_feature_pnt_pk PRIMARY KEY (gid)
) INHERITS (public.crag);

ALTER TABLE public.CHARACTER VARYING built_feature_pnt
ADD CONSTRAINT enforce_geotype_geom
CHECK (geometrytype(geom) = 'POINT'::text);

SELECT populate_geometry_columns('public.built_feature_pnt'::regclass);

CREATE UNIQUE INDEX built_feature_pnt_pk_idx
ON public.built_feature_pnt
USING btree
(gid);
ALTER TABLE public.built_feature_pnt CLUSTER ON built_feature_pnt_pk_idx;


CREATE INDEX built_feature_pnt_sptl_idx
  ON built_feature_pnt
  USING gist
  (geom);
COMMENT ON INDEX built_feature_pnt_sptl_idx
  IS 'Spatial Index';
