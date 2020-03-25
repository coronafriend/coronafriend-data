ALTER TABLE roadlink
    ADD COLUMN hash_id varchar(35);

UPDATE roadlink
    SET hash_id=(SELECT md5(ROW(endnode,startnode,roadnumbertoid,roadnametoid,geom)::TEXT))
    WHERE hash_id IS NULL;

DROP INDEX IF EXISTS roadlink_hashid_idx;
CREATE UNIQUE INDEX roadlink_hashid_idx ON roadlink(hash_id);
