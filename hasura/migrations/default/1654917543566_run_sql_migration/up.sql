CREATE OR REPLACE VIEW "public"."offers" AS 
 SELECT t.edition_id,
    t.amount,
    t.psbt,
    t.id,
    e.owner_id
   FROM (transactions t
     JOIN editions e ON (((t.edition_id = e.id) AND (((t.created_at > e.transferred_at) OR (e.transferred_at IS NULL)) AND (t.type = 'bid'::text)))));
