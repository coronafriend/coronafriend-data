DROP TABLE IF EXISTS road_data;

CREATE TABLE road_data(
    id SERIAL PRIMARY KEY NOT NULL,
    roadlink_id integer REFERENCES roadlink(hash_id),
    claim_id INTEGER REFERENCES claim_enum(id),
    road_meta jsonb,
    history jsonb
);

DROP INDEX IF EXISTS road_data_roadlink_id_idx;
CREATE INDEX road_data_roadlink_id_idx ON road_data(roadlink_id);
