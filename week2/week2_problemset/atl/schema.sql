CREATE TABLE passengers (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE airlines (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "concourse" TEXT NOT NULL CHECK("concourse" IN ('A', 'B', 'C', 'D', 'E', 'F', 'T')),
    PRIMARY KEY("id")
);

CREATE TABLE flights (
    "id" INTEGER,
    "flight_number" INTEGER NOT NULL,
    "airline_id" INTEGER,
    "departure_id" INTEGER,
    "departure_date" NUMERIC NOT NULL,
    "arrival_id" INTEGER CHECK("arrival_id" != "departure_id"),
    "arrival_date" NUMERIC NOT NULL CHECK("arrival_date" != "departure_date"),
    PRIMARY KEY("id"),
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id"),
    FOREIGN KEY("departure_id") REFERENCES "airports"("id"),
    FOREIGN KEY("arrival_id") REFERENCES "airports"("id")
);

CREATE TABLE airports (
    "id" INTEGER,
    "IATA_code" TEXT NOT NULL UNIQUE CHECK(LENGTH("IATA_code") == 3),
    "name" TEXT NOT NULL UNIQUE,
    "location" TEXT NOT NULL
    PRIMARY KEY("id")
);

CREATE TABLE check_ins (
    "id" INTEGER,
    "passenger_id" INTEGER,
    "flight_id" INTEGER,
    "timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("passenger_id") REFERENCES "passengers"("id"),
    FOREIGN KEY("flight_id") REFERENCES "flights"("id")
);
