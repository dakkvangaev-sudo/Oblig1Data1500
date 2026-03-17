-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett grunnleggende tabeller

CREATE TABLE kunde(
    kunde_id SERIAL PRIMARY KEY,
    fornavn VARCHAR(150) CHECK(length(fornavn) > 0),
    etternavn VARCHAR(150) CHECK(length(etternavn) > 0),
    mobilnummer VARCHAR(15) CHECK (mobilnummer ~ '^[0-9]{10}$'),
    epost VARCHAR(50)
);

CREATE TABLE stasjon(
    stasjon_id SERIAL PRIMARY KEY,
    adresse VARCHAR(150) CHECK (length(adresse) > 0),
    kapasitet INT CHECK (kapasitet > 0)
);

CREATE TABLE sykkel (
    sykkel_id SERIAL PRIMARY KEY,
    innkjopsdato DATE,
    tilstand VARCHAR(50),
    sykkel_status VARCHAR(150) CHECK (sykkel_status IN ('ledig', 'utleid', 'reperasjon')),
    stasjon_id INT REFERENCES stasjon(stasjon_id)
);

CREATE TABLE utleie(
    utleie_id SERIAL PRIMARY KEY,
    utleie_tidspunkt TIMESTAMP,
    innlevering_tidspunkt TIMESTAMP,
    pris NUMERIC(10,2),
    CHECK (innlevering_tidspunkt > utleie_tidspunkt),
    CHECK (pris >= 0),
    kunde_id INT REFERENCES kunde(kunde_id),
    sykkel_id INT REFERENCES sykkel(sykkel_id),
    stasjon_id INT REFERENCES stasjon(stasjon_id)
);

CREATE TABLE las (
    las_id SERIAL PRIMARY KEY,
    stasjon_id INT REFERENCES stasjon(stasjon_id),
    sykkel_id INT REFERENCES sykkel(sykkel_id)
);

-- Sett inn testdata

INSERT INTO kunde (fornavn, etternavn, mobilnummer, epost) VALUES
('Ola', 'Nordmann', '1234567890', 'ola@example.com'),
('Kari', 'Hansen', '0987654321', 'kari@example.com'),
('Per', 'Johansen', '1112223334', 'per@example.com'),
('Lise', 'Berg', '2223334445', 'lise@example.com'),
('Marius', 'Solberg', '3334445556', 'marius@example.com');

INSERT INTO stasjon (adresse, kapasitet) VALUES
('Karl Johans gate 10', 20),
('Majorstuen Torg 3', 20),
('Bjørvika 5', 20),
('Nydalen Allé 7', 20),
('Storo Senter 1', 20);

INSERT INTO las (stasjon_id) VALUES
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),

(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),
(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),

(3),(3),(3),(3),(3),(3),(3),(3),(3),(3),
(3),(3),(3),(3),(3),(3),(3),(3),(3),(3),

(4),(4),(4),(4),(4),(4),(4),(4),(4),(4),
(4),(4),(4),(4),(4),(4),(4),(4),(4),(4),

(5),(5),(5),(5),(5),(5),(5),(5),(5),(5),
(5),(5),(5),(5),(5),(5),(5),(5),(5),(5);

INSERT INTO sykkel (innkjopsdato, tilstand, sykkel_status, stasjon_id) VALUES
('2022-01-01','god','ledig',1),
('2022-01-02','ok','ledig',1),
('2022-01-03','slitt','utleid',1),
('2022-01-04','god','ledig',1),
('2022-01-05','ok','reperasjon',1),
('2022-01-06','god','ledig',1),
('2022-01-07','ok','ledig',1),
('2022-01-08','slitt','utleid',1),
('2022-01-09','god','ledig',1),
('2022-01-10','ok','ledig',1),

('2022-01-11','god','ledig',2),
('2022-01-12','ok','ledig',2),
('2022-01-13','slitt','utleid',2),
('2022-01-14','god','ledig',2),
('2022-01-15','ok','reperasjon',2),
('2022-01-16','god','ledig',2),
('2022-01-17','ok','ledig',2),
('2022-01-18','slitt','utleid',2),
('2022-01-19','god','ledig',2),
('2022-01-20','ok','ledig',2),

('2022-01-21','god','ledig',3),
('2022-01-22','ok','ledig',3),
('2022-01-23','slitt','utleid',3),
('2022-01-24','god','ledig',3),
('2022-01-25','ok','reperasjon',3),
('2022-01-26','god','ledig',3),
('2022-01-27','ok','ledig',3),
('2022-01-28','slitt','utleid',3),
('2022-01-29','god','ledig',3),
('2022-01-30','ok','ledig',3),

('2022-02-01','god','ledig',4),
('2022-02-02','ok','ledig',4),
('2022-02-03','slitt','utleid',4),
('2022-02-04','god','ledig',4),
('2022-02-05','ok','reperasjon',4),
('2022-02-06','god','ledig',4),
('2022-02-07','ok','ledig',4),
('2022-02-08','slitt','utleid',4),
('2022-02-09','god','ledig',4),
('2022-02-10','ok','ledig',4),

('2022-02-11','god','ledig',5),
('2022-02-12','ok','ledig',5),
('2022-02-13','slitt','utleid',5),
('2022-02-14','god','ledig',5),
('2022-02-15','ok','reperasjon',5),
('2022-02-16','god','ledig',5),
('2022-02-17','ok','ledig',5),
('2022-02-18','slitt','utleid',5),
('2022-02-19','god','ledig',5),
('2022-02-20','ok','ledig',5);

INSERT INTO utleie (utleie_tidspunkt, innlevering_tidspunkt, pris, kunde_id, sykkel_id, stasjon_id) VALUES
('2024-03-01 10:00','2024-03-01 10:45',39,1,3,1),
('2024-03-01 11:00','2024-03-01 11:50',49,2,7,2),
('2024-03-02 09:30','2024-03-02 10:20',39,3,12,3),
('2024-03-02 12:00','2024-03-02 12:40',29,4,15,4),
('2024-03-03 14:00','2024-03-03 14:55',59,5,22,5),
('2024-03-03 15:00','2024-03-03 15:35',25,1,9,1),
('2024-03-04 08:00','2024-03-04 08:50',49,2,18,2),
('2024-03-04 09:00','2024-03-04 09:45',39,3,27,3),
('2024-03-04 10:00','2024-03-04 10:40',29,4,33,4),
('2024-03-04 11:00','2024-03-04 11:55',59,5,41,5);
SELECT * FROM sykkel
WHERE sykkel_status = 'ledig';

SELECT * FROM sykkel
WHERE stasjon_id = 1;

SELECT * FROM utleie
WHERE kunde_id = 1;
SELECT SUM(pris) AS total_inntekt
FROM utleie;
SELECT DISTINCT k.fornavn, k.etternavn
FROM kunde k
JOIN utleie u ON k.kunde_id = u.kunde_id;
-- DBA setninger (rolle: kunde, bruker: kunde_1)



-- Eventuelt: Opprett indekser for ytelse



-- Vis at initialisering er fullført (kan se i loggen fra "docker-compose log"
SELECT 'Database initialisert!' as status;