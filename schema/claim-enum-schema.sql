DROP TABLE IF EXISTS claim_enum;

CREATE TABLE claim_enum (
    id SERIAL PRIMARY KEY NOT NULL,
    claim varchar(7)
);

INSERT INTO claim_enum(claim) VALUES
    ('full'),
    ('partial'),
    ('empty');
