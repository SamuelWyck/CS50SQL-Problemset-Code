CREATE TABLE meteorites (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" REAL DEFAULT NULL,
    "discovery" TEXT NOT NULL CHECK("discovery" IN ('Fell', 'Found')),
    "year" NUMERIC DEFAULT NULL,
    "lat" REAL DEFAULT NULL,
    "long" REAL DEFAULT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE meteorites_temp (
    "name" TEXT NOT NULL,
    "id" INTEGER NOT NULL,
    "nametype" TEXT,
    "class" TEXT NOT NULL,
    "mass" REAL DEFAULT NULL,
    "discovery" TEXT NOT NULL,
    "year" NUMERIC DEFAULT NULL,
    "lat" REAL DEFAULT NULL,
    "long" REAL DEFAULT NULL
);

.import --csv meteorites.csv --skip 1 meteorites_temp

DELETE FROM meteorites_temp WHERE nametype = 'Relict';

UPDATE meteorites_temp SET mass = NULL WHERE mass = '';
UPDATE meteorites_temp SET year = NULL WHERE year = '';
UPDATE meteorites_temp SET lat = NULL WHERE lat = '';
UPDATE meteorites_temp SET long = NULL WHERE long = '';

UPDATE meteorites_temp SET mass = ROUND(mass, 2) WHERE mass IS NOT NULL;
UPDATE meteorites_temp SET lat = ROUND(lat, 2) WHERE lat IS NOT NULL;
UPDATE meteorites_temp SET long = ROUND(long, 2) WHERE long IS NOT NULL;

INSERT INTO meteorites (name, class, mass, discovery, year, lat, long)
SELECT name, class, mass, discovery, year, lat, long FROM meteorites_temp ORDER BY year, name;

