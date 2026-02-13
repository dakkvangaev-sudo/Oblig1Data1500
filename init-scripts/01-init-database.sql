CREATE TABLE kunde (
    kunde_id SERIAL PRIMARY KEY,
    fornavn VARCHAR(50),
    etternavn VARCHAR(50),
    epost VARCHAR(100),
    mobilnummer VARCHAR(20)
);

CREATE TABLE stasjon (
    stasjon_id SERIAL PRIMARY KEY,
    navn VARCHAR(100),
    adresse VARCHAR(150),
    kapasitet INT
);

CREATE TABLE las (
    las_id SERIAL PRIMARY KEY,
    las_kode VARCHAR(50)
);

CREATE TABLE sykkel (
    sykkel_id SERIAL PRIMARY KEY,
    status VARCHAR(20),
    stasjon_id INT REFERENCES stasjon(stasjon_id),
    las_id INT REFERENCES las(las_id)
);

CREATE TABLE utleie (
    utleie_id SERIAL PRIMARY KEY,
    kunde_id INT REFERENCES kunde(kunde_id),
    sykkel_id INT REFERENCES sykkel(sykkel_id),
    hentet_stasjon_id INT REFERENCES stasjon(stasjon_id),
    levert_stasjon_id INT REFERENCES stasjon(stasjon_id),
    start_tid TIMESTAMP,
    slutt_tid TIMESTAMP,
    pris NUMERIC(8,2)
);
