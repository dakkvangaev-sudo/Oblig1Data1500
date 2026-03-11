# Besvarelse - Refleksjon og Analyse

**Student:** [Dåkk Ruslanovitsj Vangaev]

**Studentnummer:** [Davan1754]

**Dato:** [01.03.2025]

---

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

**Identifiserte entiteter:**

[Sykkel, Stasjon, Kunde og utleie]

**Attributter for hver entitet:**

[kunde: fornavn, etternavn, mobilnummer, epost og kunde_id
Sykkel: sykkel_id, innkjøpsdato, tilstand og sykkel_status
Stasjon: adresse og kapasitet
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

KUNDE{
    varchar fornavn
    varchar etternavn
    varchar mobilnummer
    varchar epost
}

SYKKEL {
    DATE innkjopsdato
    VARCHAR tilstand
    VARCHAR sykkel_status
}

STASJON{
    varcahr adresse
    int kapasitet
}

UTLEIE{
    date utleie
    date innlevering
    numeric pris
}t]

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

SYKKEL {
		serial sykkelId pk ""  
		DATE innkjopsdato  ""  
		VARCHAR tilstand  ""  
		VARCHAR sykkel_status  ""  
	}

STASJON {
		serial stasjonId pk ""  
		serial sykkelId fk ""  
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

[Skriv ditt svar her - f.eks. skjermbilder eller output fra terminalen som viser at databasen ble opprettet uten feil]

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
[Skriv resultatet av spørringen her - list opp alle tabellene som ble opprettet]
```

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
[Skriv din SQL-kode for å opprette rollen 'kunde' her]
```

**SQL for å opprette bruker:**

```sql
[Skriv din SQL-kode for å opprette brukeren 'kunde_1' her]
```

**SQL for å tildele rettigheter:**

```sql
[Skriv din SQL-kode for å tildele rettigheter til rollen her]
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
[Skriv din SQL-kode for VIEW her]
```

**Ulempe med VIEW vs. POLICIES:**

[Skriv ditt svar her - diskuter minst én ulempe med å bruke VIEW for autorisasjon sammenlignet med POLICIES]

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

[Skriv din utregning her]

**Estimat for lagringskapasitet:**

[Skriv din utregning her - vis hvordan du har beregnet lagringskapasiteten for hver tabell]

**Totalt for første år:**

[Skriv ditt estimat her]

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

[Skriv ditt svar her - gi konkrete eksempler fra CSV-filen som viser redundans]

**Problem 2: Inkonsistens**

[Skriv ditt svar her - forklar hvordan redundans kan føre til inkonsistens med eksempler]

**Problem 3: Oppdateringsanomalier**

[Skriv ditt svar her - diskuter slette-, innsettings- og oppdateringsanomalier]

**Fordeler med en indeks:**

[Skriv ditt svar her - forklar hvorfor en indeks ville gjort spørringen mer effektiv]

**Case 1: Indeks passer i RAM**

[Skriv ditt svar her - forklar hvordan indeksen fungerer når den passer i minnet]

**Case 2: Indeks passer ikke i RAM**

[Skriv ditt svar her - forklar hvordan flettesortering kan brukes]

**Datastrukturer i DBMS:**

[Skriv ditt svar her - diskuter B+-tre og hash-indekser]

---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**

[Skriv ditt svar her - f.eks. heap-fil, LSM-tree, eller annen egnet datastruktur]

**Begrunnelse:**

**Skrive-operasjoner:**

[Skriv ditt svar her - forklar hvorfor datastrukturen er egnet for mange skrive-operasjoner]

**Lese-operasjoner:**

[Skriv ditt svar her - forklar hvordan datastrukturen håndterer sjeldne lese-operasjoner]

---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

[Skriv ditt svar her - argumenter for validering i ett eller flere lag]

**Validering i nettleseren:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i applikasjonslaget:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i databasen:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Konklusjon:**

[Skriv ditt svar her - oppsummer hvor validering bør gjøres og hvorfor]

---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

[Skriv din refleksjon her - diskuter sentrale konsepter du har lært]

**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

[Skriv din refleksjon her - koble oppgaven til læringsmålene i emnet]

Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**

[Skriv din refleksjon her - diskuter hvilke deler av oppgaven som var mest krevende]

**Hva har du lært om databasedesign:**

[Skriv din refleksjon her - reflekter over prosessen med å designe en database fra bunnen av]

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`]


**Eventuelle feil og rettelser:**

[Skriv ditt svar her - hvis noen tester feilet, forklar hva som var feil og hvordan du rettet det]

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
