CREATE OR REPLACE VIEW "public"."recentactivity" AS 
 SELECT t1.id,
    t1.hash,
    t1.artwork_id,
    t1.type,
    t1.amount,
    t1.user_id,
    t1.created_at,
    t1.asset,
    t1.psbt,
    t1.confirmed,
    t1.bid_id,
    t1.contract
   FROM (transactions t1
     JOIN ( SELECT t.artwork_id,
            max(t.created_at) AS max_created_at
           FROM (transactions t
             JOIN artworks a ON ((a.id = t.artwork_id)))
          WHERE ((t.type <> 'receipt'::text) AND ((a.asking_asset IS NOT NULL) OR (a.transferred_at IS NOT NULL)))
          GROUP BY t.artwork_id) t2 ON (((t1.artwork_id = t2.artwork_id) AND (t1.created_at = t2.max_created_at))))
  ORDER BY t1.created_at DESC
 LIMIT 20;
