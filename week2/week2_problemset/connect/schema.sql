CREATE TABLE users (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE schools (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "type" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "year_founded" NUMERIC NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE companies (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE user_connections (
    "id" INTEGER,
    "first_user_id" INTEGER,
    "second_user_id" INTEGER CHECK("second_user_id" != "first_user_id"),
    PRIMARY KEY("id"),
    FOREIGN KEY("first_user_id") REFERENCES "users"("id"),
    FOREIGN KEY("second_user_id") REFERENCES "users"("id")
);

CREATE TABLE school_affiliations (
    "id" INTEGER,
    "user_id" INTEGER,
    "school_id" INTEGER,
    "start_date" NUMERIC NOT NULL,
    "end_date" NUMERIC CHECK("end_date" != "start_date"),
    "degree" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("school_id") REFERENCES "schools"("id")
);

CREATE TABLE company_affiliations (
    "id" INTEGER,
    "user_id" INTEGER,
    "company_id" INTEGER,
    "start_date" NUMERIC NOT NULL,
    "end_date" NUMERIC CHECK("end_date" != "start_date"),
    "title" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "user_id"("id"),
    FOREIGN KEY("company_id") REFERENCES "companies"("id")
);
