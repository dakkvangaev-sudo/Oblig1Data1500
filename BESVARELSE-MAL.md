# Besvarelse - Refleksjon og Analyse

**Student:** [Dåkk Ruslanovitsj Vangaev]

**Studentnummer:** [Davan1754]

**Dato:** [01.03.2025]

---

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

**Identifiserte entiteter:**

[Sykkel, Stasjon, Kunde, lås og utleie]

**Attributter for hver entitet:**

[kunde: fornavn, etternavn, mobilnummer, epost og kunde_id
Sykkel: sykkel_id, innkjøpsdato, tilstand og sykkel_status
Stasjon: adresse og kapasitet
lås: lås_id
utleie: utleie_tidspunkt, innlevering_tidspunkt]

---

### Oppgave 1.2: Datatyper og `CHECK`-constraints

**Valgte datatyper og begrunnelser:**

[
VARCHAR for tall, text og tegn. Brukes på: fornavn, etternavn, mobilnummer, epost, tilstand, sykkel_status og adresse.

DATE for kun dato. brukes på: innkjøpsdato.

Int for heltall. brukes på kapasitet.

DATE TIME for dato og tid. brukes på: utleie_tidspunkt og innlevering_tidspunkt

NUMERIC(10,2) for tall og desimaltall. brukes på: pris
]

**`CHECK`-constraints:**

[
check(length(fornavn) > 0): for å sjekke om fornavn har høyere verdi enn 0.

check(length(etternavn) > 0): for å sjekke om etternavn har høyere verdi enn 0.

check (mobilnummer ~ "^[0-9]{10}$"): sjekker om det er tall mellom 0-9 og sjekker om det er 10 antall tall.

CHECK (sykkel_status IN ('ledig', 'utleid', 'reperasjon')): sjekker om sykkel_status har verdien ledig, utleid eller reperasjon.

CHECK (length(adresse) > 0): sjekker om adresse har høyere verdi enn 0

CHECK (kapasitet > 0): sjekker om kapasitet har høyere verdi enn 0

CHECK (innlevering_tidspunkt > utleie_tidspunkt): sjekker om innlevering_tidspunkt er etter utleie_tidspunkt

CHECK (pris >= 0): sjekker om verdien til pris er mer eller lik 0
]

**ER-diagram:**

[
erDiagram
	direction TB
	KUNDE {
		varchar fornavn  ""  
		varchar etternavn  ""  
		varchar mobilnummer  ""  
		varchar epost  ""  
		serial kundeId pk ""  
	}
	 LÅS {
        int lås_id PK
        int posisjon
    }


	SYKKEL {
		serial sykkelId pk ""  
		DATE innkjopsdato  ""  
		VARCHAR tilstand  ""  
		VARCHAR sykkel_status  ""  
	}

	STASJON {
		serial stasjonId pk ""  
		varcahr adresse  ""  
		int kapasitet  ""  
	}

	UTLEIE {
		date utleie  ""  
		date innlevering  ""  
		numeric pris  ""  
	}

]
---

### Oppgave 1.3: Primærnøkler

**Valgte primærnøkler og begrunnelser:**

[
brukte serial primary key.
]

**Naturlige vs. surrogatnøkler:**

[ I motsetnig til nøkler som brukes i f.eks mobilnummer fornavn, så kan ikke den endres. Noe som gjør den mer stabil.]

**Oppdatert ER-diagram:**

[
erDiagram
	direction TB
	KUNDE {
		varchar fornavn  ""  
		varchar etternavn  ""  
		varchar mobilnummer  ""  
		varchar epost  ""  
		serial kundeId pk ""  
	}
	 LÅS {
        int lås_id PK
        int stasjon_id FK
        int posisjon
    }


	SYKKEL {
		serial sykkelId pk ""  
		DATE innkjopsdato  ""  
		VARCHAR tilstand  ""  
		VARCHAR sykkel_status  ""  
		serial stasjonId fk ""  
	}

	STASJON {
		serial stasjonId pk ""  
		varcahr adresse  ""  
		int kapasitet  ""  
	}

	UTLEIE {
		serial stasjonId fk ""  
		serial sykkelId fk ""  
		date utleie  ""  
		date innlevering  ""  
		numeric pris  ""  
		serial kundeId fk ""  
	}

	KUNDE ||--o{ UTLEIE : "utleie får informasjon av kunde"
    SYKKEL ||--o{ UTLEIE : "sykkel låses opp og utleie for informasjon av sykkel"
    STASJON ||--o{ LÅS : "stasjon inneholder låser og sykkler"
    STASJON ||--o{ SYKKEL : "har sykler"
    LÅS ||--o{ SYKKEL : "sykkel har låser"
  ]

---

### Oppgave 1.4: Forhold og fremmednøkler

**Identifiserte forhold og kardinalitet:**

**Fremmednøkler:**

[
Sykkel ID: brukes på stasjon og utleie. Stasjon for å vite hvilken sykkel som ligger igjen i stasjonen og utleie for å vite hvilken sykkel som blir leid ut.
]

**Oppdatert ER-diagram:**

[erDiagram
	direction TB
	KUNDE {
		varchar fornavn  ""  
		varchar etternavn  ""  
		varchar mobilnummer  ""  
		varchar epost  ""  
		serial kundeId pk ""  
	}

SYKKEL {
		serial sykkelId pk ""  
		DATE innkjopsdato  ""  
		VARCHAR tilstand  ""  
		VARCHAR sykkel_status  ""  
		serial stasjonId pk ""  
	}

STASJON {
		serial stasjonId pk ""  
		varcahr adresse  ""  
		int kapasitet  ""  
	}

UTLEIE {
		serial stasjonId fk ""  
		serial sykkelId fk ""  
		date utleie  ""  
		date innlevering  ""  
		numeric pris  ""  
		serial kundeId fk ""  
	}

STASJON}|--|{UTLEIE:"  "
SYKKEL}|--|{STASJON:"  "
SYKKEL}|--|{UTLEIE:"  "
KUNDE}|--|{UTLEIE:"  "]

---

### Oppgave 1.5: Normalisering

**Vurdering av 1. normalform (1NF):**

[alle attributtene er atomiske. navn, mobillnumnmer, epost,datoer, pris og ider har kun en verdi]

**Vurdering av 2. normalform (2NF):**

[bruker surrogatnøkkler i alle tabellene]

**Vurdering av 3. normalform (3NF):**

[ingen transitive avhengigheter]

**Eventuelle justeringer:**

[Skriv ditt svar her - hvis modellen ikke var på 3NF, forklar hvilke justeringer du har gjort]

---

## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:**

[Bekreft at du har lagt SQL-skriptet i `init-scripts/01-init-database.sql`]

**Antall testdata:**

- Kunder: [antall]
- Sykler: [antall]
- Sykkelstasjoner: [antall]
- Låser: [antall]
- Utleier: [antall]

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**

[
PS C:\Users\Dåkk\OneDrive - OsloMet\Dokumenter\Oblig1Data1500> docker-compose up -d
[+] up 2/2
 ✔ Network oblig1data1500_data1500-network Created                                                                              0.1s
 ✔ Container data1500-postgres             Created                                                                              0.3s]

**Spørring mot systemkatalogen:**

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

**Resultat:**

```
[
	PS C:\Users\Dåkk\OneDrive - OsloMet\Dokumenter\Oblig1Data1500> docker exec -it data1500-postgres psql -U admin -d oblig01
psql (15.17)
Type "help" for help.

oblig01=# SELECT tablename
oblig01-# FROM pg_catalog.pg_tables
oblig01-# WHERE schemaname = 'public';
 tablename
-----------
 stasjon
 sykkel
 kunde
 utleie
 las
(5 rows)

oblig01=# SELECT * FROM sykkel;
 sykkel_id | innkjopsdato | tilstand | sykkel_status | stasjon_id
-----------+--------------+----------+---------------+------------
         1 | 2022-01-01   | god      | ledig         |          1
         2 | 2022-01-02   | ok       | ledig         |          1
         3 | 2022-01-03   | slitt    | utleid        |          1
         4 | 2022-01-04   | god      | ledig         |          1
         5 | 2022-01-05   | ok       | reperasjon    |          1
         6 | 2022-01-06   | god      | ledig         |          1
         7 | 2022-01-07   | ok       | ledig         |          1
         8 | 2022-01-08   | slitt    | utleid        |          1
         9 | 2022-01-09   | god      | ledig         |          1
        10 | 2022-01-10   | ok       | ledig         |          1
        11 | 2022-01-11   | god      | ledig         |          2
        12 | 2022-01-12   | ok       | ledig         |          2
        13 | 2022-01-13   | slitt    | utleid        |          2
        14 | 2022-01-14   | god      | ledig         |          2
        15 | 2022-01-15   | ok       | reperasjon    |          2
        16 | 2022-01-16   | god      | ledig         |          2
        17 | 2022-01-17   | ok       | ledig         |          2
        18 | 2022-01-18   | slitt    | utleid        |          2
        19 | 2022-01-19   | god      | ledig         |          2
        20 | 2022-01-20   | ok       | ledig         |          2
        21 | 2022-01-21   | god      | ledig         |          3
        22 | 2022-01-22   | ok       | ledig         |          3
        23 | 2022-01-23   | slitt    | utleid        |          3
        24 | 2022-01-24   | god      | ledig         |          3
        25 | 2022-01-25   | ok       | reperasjon    |          3
        26 | 2022-01-26   | god      | ledig         |          3
        27 | 2022-01-27   | ok       | ledig         |          3
        28 | 2022-01-28   | slitt    | utleid        |          3
        29 | 2022-01-29   | god      | ledig         |          3
        30 | 2022-01-30   | ok       | ledig         |          3
        31 | 2022-02-01   | god      | ledig         |          4
        32 | 2022-02-02   | ok       | ledig         |          4
        33 | 2022-02-03   | slitt    | utleid        |          4
        34 | 2022-02-04   | god      | ledig         |          4
        35 | 2022-02-05   | ok       | reperasjon    |          4
        36 | 2022-02-06   | god      | ledig         |          4
        37 | 2022-02-07   | ok       | ledig         |          4
        38 | 2022-02-08   | slitt    | utleid        |          4
        39 | 2022-02-09   | god      | ledig         |          4
        40 | 2022-02-10   | ok       | ledig         |          4
        41 | 2022-02-11   | god      | ledig         |          5
        42 | 2022-02-12   | ok       | ledig         |          5
        43 | 2022-02-13   | slitt    | utleid        |          5
        44 | 2022-02-14   | god      | ledig         |          5
        45 | 2022-02-15   | ok       | reperasjon    |          5
        46 | 2022-02-16   | god      | ledig         |          5
        47 | 2022-02-17   | ok       | ledig         |          5
        48 | 2022-02-18   | slitt    | utleid        |          5
        49 | 2022-02-19   | god      | ledig         |          5
        50 | 2022-02-20   | ok       | ledig         |          5
(50 rows)

oblig01=#
oblig01=# SELECT * FROM kunde;
 kunde_id | fornavn | etternavn | mobilnummer |       epost
----------+---------+-----------+-------------+--------------------
        1 | Ola     | Nordmann  | 1234567890  | ola@example.com
        2 | Kari    | Hansen    | 0987654321  | kari@example.com
        3 | Per     | Johansen  | 1112223334  | per@example.com
        4 | Lise    | Berg      | 2223334445  | lise@example.com
        5 | Marius  | Solberg   | 3334445556  | marius@example.com
(5 rows)

]
```

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
[CREATE role kunde;]
```

**SQL for å opprette bruker:**

```sql
[create user kunde_1 with PASSWORD 'passord';
]
```

**SQL for å tildele rettigheter:**

```sql
[
	grant kunde to kunde_1;

grant SELECT on kunde to kunde;
GRANT SELECT on sykkel to kunde;
GRANT SELECT on stason to kunde;
grant SELECT on utleie to kunde;
grant select on las to kunde; 
]
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
[
	grant SELECT on all VIEWS in SCHEMA PUBLIC to kunde;

create VIEW sykkel_utleie_system AS
SELECT * 
FROM utleie
WHERE kunde_id = current_user::text::int;
]
```

**Ulempe med VIEW vs. POLICIES:**

[
En policy prioriterer sikkerhet og dette kan ikke omgås. i motsetning til policy kan bruker av view fortsatt få tilgang til tabellene hvis de har rettigheter. Dette er basert på select, mens i policy er det integrert i databasen.
]

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

[
	høysesong: 20 000 * 5 = 100 000
	Mellomsesong: 5 000 * 4 = 20 000
	Lavsesong 500 * 3 = 1500

	100 000 + 20 000 + 1 500 = 121 500 utleier.


	tabell: kunde
	serian (int) = 4 bytes
	varchar(150) = 50 bytes
	varchar(150) = 50 bytes
	varchar(15)= 15 bytes
	varchar(50) = 30

	størrelse: 4 + 50 + 50 + 15 + 30 = 149
	overhead: 23 + (5x4) = 43
	total: 149 + 43 = 192 


	tabell stasjon:
	serial = 4 bytes
	varchar(150) = 50 bytes
	INT = 4 bytes

	størrelse: 4 + 50 + 4 = 58
	overhead: 23 + (3x4) = 35
	total: 58 + 35 = 93 


	tabell: sykkel
	serial = 4 bytes
	date = 4 bytes
	varchar(50) = 20 bytes
	varchar(150) = 50 bytes
	int = 4 bytes

	størrelse: 4 + 4 + 20 + 50 + 4 = 82
	23 + (5x4) = 43
	82 + 43 = 125 


	tabell: utleie
	serial = 4 bytes
	timestamp = 8 bytes
	timestamp = 8 bytes
	numeric(10,2) = 16 bytes
	3xint = 12 bytes

	størrelse: 4 + 8 + 8 + 16 + 12 = 48
	overhead: 23 + (7x4) = 51
	total: 48 + 51 = 99 


	tabell: las
	serial = 4 bytes
	2x int = 8 bytes

	størrelse = 8 + 4 = 12
	overhead: 23 + (3x4) = 35
	total: 12 + 35 = 47 

	
	total til sammen: 192 + 93 + 125 + 99 + 47 = 556

	til sammen så vil alle tabellene tilsvare ca 556 bytes

	121 500 x 556 = 67 554 000 bytes ca= 64.4MB

]


---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

[
betydningen på redusans er at informasjonen gjentas. Exempel på dette kan du finne i Ole,Hansen,+4791234567,ole.hansen@example.com og Kari,Olsen,+4792345678,kari.olsen@example.com

]

**Problem 2: Inkonsistens**

[
når en data gjentas kan det oppstå inkonsistens noe som gjør at det kan oppstå feil som f.eks stavefeil.
]

**Problem 3: Oppdateringsanomalier**

[
hvis det blir endring på informasjonen til en kunde så må alle radene oppdateres. Med dette kan det oppstå inkonsistens. Dette blir da en oppdateringsanomali.

hvis det hender i det kunden må innsette informasjon blir det da innsettingsanomali. Eksempel på dette kan være at kunde må sette inn kundeinfo, stasjonsinfo og utleietidspunkt samtidig selv om det ikke gir mening.

sletteanomalier oppstår når det hender feil i sletteovergangen. Ett eksempel på dette kan være at en kunde kun hadde en utleie og ville slette denne raden, men så ble all imformasjonen om henne sletta.

kor oppsumert så er oppdateringsanomali feil ved informasjonsoppdatering. innsetingsanomali er feil i det kunden skal sette inn informasjon og sletteanomali er feil som oppstår i det kunden skal slette informasjon
]

**Fordeler med en indeks:**

[
fordeler med indeks er at den kan søke i loggen automatisk istedenfor at du må gå gjennom manuelt rad for rad.
]

**Case 1: Indeks passer i RAM**

[
når indeks passer inn i RAM kan PostgreSQL søke uten disktilgang og kun de relevante radene blir henta.
]

**Case 2: Indeks passer ikke i RAM**

[
hvis indeks er større enn RAM så må PostgreSQL hente deler av indeksen fra disk. DBMS må ta i bruk av flettesortering for å bygge eller rebalansere indeksen
]

**Datastrukturer i DBMS:**

[
B+-tre er en standard datastruktur for indekser i relasjondatabaser. Den er bra for range (>,<). God for både lesing og skriving.

Hashing er rask for eksakt oppslag(=)
]

---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**

[
LMS-treet er det beste valget
]

**Begrunnelse:**

**Skrive-operasjoner:**

[
Loggingen til LMS-treet er append only. Dette gjør at historikken ikke kan bli slettet og at gamle rader ikke blir oppdatert.
]

**Lese-operasjoner:**

[
ved lesing søker systemet først i minnet og deretter i segmentene. Dette gir god ytelse for lesehastighet, skrivehastinghet og belastning.
]

---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

[
validering burde gjøres i alle lag.
]

**Validering i nettleseren:**

[
fordeler: mindre trafikk til serveren, rask tilbakemelding og enkjelt og implementere.

ulemper: ingen sikkerhet.

]

**Validering i applikasjonslaget:**

[
fordeler: gir detaljert feilmelding til brukeren.

ulemper: krever mer kode dersom applikasjonen må unngås feil.

]

**Validering i databasen:**

[
fordeler: bruker unike koder. Er siste forsvarslinje for å nekte ugyldig data.

ulemper: gir ikke like brukervennlig feilmelding. Kan ikke validere alt
]

**Konklusjon:**

[
Det er lurest å validere alle lag dersom den går gjennom hele systemet og unngår mest mulig feil
]

---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

[
i del 1 så lærte jeg å sette opp en plan. Jeg lærte å bruke erDiagram også lærte jeg forskjellene mellom erDiagram og sql.

del 2 så lærte jeg mer om sql koding. jeg lærte mye om å gi verdier til atributter. jeg lærte også mye om unike datatyper som ble brukt. til slutt så lærte jeg å runne koden og teste den via spørringer med bruk av docker container og terminalen.

i del 3 så lærte jeg å opprette bruker, roller og view. jeg forstod også at man må de enkelte tinga og gi bruker tilgang til view og roller.

i del 4 så lærte jeg å analysere databasen. Jeg lærte om forskjellige datastrukturer som f.eks LMS. I tilleg til det så lærte jeg mye om RAM og kapasitet. Lærte om hvor mye bytes forskjellige datatyper bruker.
]

**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**
[
med tanke på at denne obligen var lang, godt gjennomtenkt og varierende har jeg lært godt om mye forskjellig. dette hjelper veldig mye.
]

Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**

[
største utfordninger er å lage selve strukturen i sql. 
]

**Hva har du lært om databasedesign:**

[
jeg har lært om å tenke gjennom hva jeg får bruk for og hvordan oppsettet skal se ut.
]

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`]


**Eventuelle feil og rettelser:**

[
Eneste problemet som oppstod for meg var at tabellene ville ikke opprettes i det jeg skulle prøve å runne programemt. Usikker på hvorfor det skjedde, men når jeg sletta docker containeren og oppretta den opp på nytt igjen så funka alt som forventa.
]

---

## Del 6: Bonusoppgaver (Valgfri)

### Oppgave 6.1: Trigger for lagerbeholdning

**SQL for trigger:**

```sql
[Skriv din SQL-kode for trigger her, hvis du har løst denne oppgaven]
```

**Forklaring:**

[Skriv ditt svar her - forklar hvordan triggeren fungerer]

**Testing:**

[Skriv ditt svar her - vis hvordan du har testet at triggeren fungerer som forventet]

---

### Oppgave 6.2: Presentasjon

**Lenke til presentasjon:**

[Legg inn lenke til video eller presentasjonsfiler her, hvis du har løst denne oppgaven]

**Hovedpunkter i presentasjonen:**

[Skriv ditt svar her - oppsummer de viktigste punktene du dekket i presentasjonen]

---

**Slutt på besvarelse**
