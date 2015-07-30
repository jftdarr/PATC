UPDATE named_trail 
SET trailclass = (SELECT
CAST(((avg(b.trailclass) + avg(b.treadtc) + avg(b.obstacletc))/3) AS int)
FROM named_trail n
JOIN (
SELECT trailclass, treadtc, obstacletc, geom FROM public.built_trail
UNION ALL
SELECT structure_class AS trailclass, treadtc, obstacletc, geom FROM public.trail_crossing
UNION ALL
SELECT structure_class AS trailclass, treadtc, obstacletc, geom FROM public.trail_steps) b on ST_Intersects(n.geom,b.geom)
WHERE named_trail.geom = n.geom
GROUP BY n.geom
);

UPDATE named_trail
SET difficulty = (SELECT
CAST(avg(difficultygrade) AS int)
FROM named_trail n
JOIN built_trail b on ST_Intersects(n.geom,b.geom)
WHERE named_trail.geom = n.geom
GROUP BY n.geom
);
