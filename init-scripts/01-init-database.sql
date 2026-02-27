init-scripts/01-init-database.sql

-- DROP TABLES (for re-run)
DROP TABLE IF EXISTS utleie CASCADE;
DROP TABLE IF EXISTS sykkel CASCADE;
DROP TABLE IF EXISTS las CASCADE;
DROP TABLE IF EXISTS stasjon CASCADE;
DROP TABLE IF EXISTS kunde CASCADE;

-- STASJON
CREATE TABLE stasjon (
    stasjon_id SERIAL PRIMARY KEY,
    navn VARCHAR(100) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    kapasitet INT NOT NULL CHECK (kapasitet > 0)
);

-- LÅS
CREATE TABLE las (
    las_id SERIAL PRIMARY KEY,
    stasjon_id INT NOT NULL REFERENCES stasjon(stasjon_id) ON DELETE CASCADE,
    nummer INT NOT NULL
);

-- KUNDE
CREATE TABLE kunde (
    kunde_id SERIAL PRIMARY KEY,
    fornavn VARCHAR(100) NOT NULL,
    etternavn VARCHAR(100) NOT NULL,
    mobilnummer VARCHAR(8) UNIQUE NOT NULL CHECK (mobilnummer ~ '^[0-9]{8}$'),
    epost VARCHAR(255) UNIQUE NOT NULL,
    registrert_dato TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SYKKEL
CREATE TABLE sykkel (
    sykkel_id SERIAL PRIMARY KEY,
    status VARCHAR(20) NOT NULL CHECK (status IN ('tilgjengelig','utleid')),
    stasjon_id INT REFERENCES stasjon(stasjon_id),
    las_id INT REFERENCES las(las_id),
    tatt_i_bruk_dato DATE NOT NULL
);

-- UTLEIE
CREATE TABLE utleie (
    utleie_id SERIAL PRIMARY KEY,
    kunde_id INT NOT NULL REFERENCES kunde(kunde_id),
    sykkel_id INT NOT NULL REFERENCES sykkel(sykkel_id),
    utlevert_tid TIMESTAMP NOT NULL,
    innlevert_tid TIMESTAMP,
    belop NUMERIC(10,2) CHECK (belop >= 0)
);

-- TESTDATA

-- 5 STASJONER
INSERT INTO stasjon (navn, adresse, kapasitet) VALUES
('Sentrum','Storgata 1',20),
('Majorstuen','Bogstadveien 10',20),
('Grunerlokka','Thorvald Meyers gate 5',20),
('Bjorvika','Dronning Eufemias gate 15',20),
('Nydalen','Nydalsveien 30',20);

-- 100 LÅSER (20 per stasjon)
INSERT INTO las (stasjon_id, nummer)
SELECT s.stasjon_id, generate_series(1,20)
FROM stasjon s;

-- 5 KUNDER
INSERT INTO kunde (fornavn, etternavn, mobilnummer, epost) VALUES
('Ola','Nordmann','12345678','ola@test.no'),
('Kari','Hansen','23456789','kari@test.no'),
('Per','Johansen','34567890','per@test.no'),
('Anne','Larsen','45678901','anne@test.no'),
('Maria','Berg','56789012','maria@test.no');

-- 100 SYKLER
INSERT INTO sykkel (status, stasjon_id, las_id, tatt_i_bruk_dato)
SELECT 
    'tilgjengelig',
    (RANDOM()*4 + 1)::INT,
    (RANDOM()*99 + 1)::INT,
    '2023-01-01'
FROM generate_series(1,100);

-- 50 UTLEIER
INSERT INTO utleie (kunde_id, sykkel_id, utlevert_tid, innlevert_tid, belop)
SELECT
    (RANDOM()*4 + 1)::INT,
    (RANDOM()*99 + 1)::INT,
    NOW() - INTERVAL '2 days',
    NOW() - INTERVAL '1 day',
    ROUND((RANDOM()*200)::numeric,2)
FROM generate_series(1,50);

-- Vis tabeller
SELECT tablename
FROM pg_catalog.pg_tables
WHERE schemaname='public';
