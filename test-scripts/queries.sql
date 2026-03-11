erDiagram

create table kunde{
    kunde_id serial primary key 1/MIN
    fornavn VARCHAR(150) 
    check(length(fornavn) > 0)
    etternavn VARCHAR(150) 
    check(length(etternavn) > 0)
    mobilnummer VARCHAR(15) 
    check (mobilnummer ~ "^[0-9]{10}$")
    epost VARCHAR(50)
}

create table Sykkel {
    sykkel_id serial PRIMARY key 1/MIN
    innkjøpsdato DATE
    tilstand VARCHAR(50) 
    sykkel_status VARCHAR(150)
    CHECK (sykkel_status IN ('ledig', 'utleid', 'reperasjon')),
    Foreign Key (stasjon_id) REFERENCES (stasjon(stasjon_id))
}

create table stasjon{
    stasjon_id serial primary key 1/MIN
    adresse VARCHAR(150) 
    CHECK (length(adresse) > 0)
    kapasitet int
    CHECK (kapasitet > 0)
}

create table utleie{
    utleie_tidspunkt DATE TIME
    innlevering_tidspunkt DATE TIME
    pris NUMERIC(10,2)
    CHECK (innlevering_tidspunkt > utleie_tidspunkt)
    CHECK (pris >= 0)
    Foreign Key (kunde_id) REFERENCES (kunde(kunde_id))
    Foreign Key (sykkel_id) REFERENCES (sykkel(sykkel_id))
    Foreign Key (stasjon_id) REFERENCES (stasjon(stasjon_id))

}
