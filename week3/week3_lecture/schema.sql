-- Demonstrates schema of mfa.db for insert files
-- Creates mfa.db

-- Deletes prior tables if they exist

-- Creates collections table
CREATE TABLE "collections" (
    "id" INTEGER,
    "title" TEXT NOT NULL,
    "accession_number" TEXT NOT NULL UNIQUE,
    "acquired" NUMERIC,
    PRIMARY KEY("id")
);
