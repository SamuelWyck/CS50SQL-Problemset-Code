--Resetting the database if need be
DROP INDEX IF EXISTS people_index;
DROP INDEX IF EXISTS waiver_index;
DROP INDEX IF EXISTS ticket_index;
DROP INDEX IF EXISTS booking_date_index;
DROP INDEX IF EXISTS booking_racetime_index;
DROP INDEX IF EXISTS booking_ticket_index;

DROP VIEW IF EXISTS "active_waivers";
DROP VIEW IF EXISTS "booking_info";
DROP VIEW IF EXISTS "booking_contents";
DROP VIEW IF EXISTS "booking_people";

DROP TABLE IF EXISTS booking_tickets;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS waivers;
DROP TABLE IF EXISTS race_tickets;
DROP TABLE IF EXISTS bookings;

--yummy yummy bits
VACUUM;

--table to represent people
CREATE TABLE people (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER,
    "email" TEXT NOT NULL,
    "phone_number" NUMERIC,
    PRIMARY KEY("id")
);

--table to represent waivers required to race
CREATE TABLE waivers (
    "id" INTEGER,
    "person_id" INTEGER NOT NULL,
    "signed_date" NUMERIC DEFAULT CURRENT_DATE,
    "end_date" DEFAULT (date('now', '+1 year')),
    PRIMARY KEY("id"),
    FOREIGN KEY("person_id") REFERENCES "people"("id") ON DELETE CASCADE
);

--table to represent different types of tickets sold
CREATE TABLE race_tickets (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "number_of_laps" INTEGER NOT NULL,
    "price" REAL NOT NULL,
    PRIMARY KEY("id")
);

--table to keep track of race bookings
CREATE TABLE bookings (
    "id" INTEGER,
    "booking_holder_id" INTEGER,
    "tickets_booked" INTEGER NOT NULL,
    "race_time" NUMERIC NOT NULL,
    "booking_date" NUMERIC NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("booking_holder_id") REFERENCES "people"("id") ON DELETE SET NULL
);

--table to link a ticket to a booking and link a waiver to that ticket
CREATE TABLE booking_tickets (
    "booking_id" INTEGER NOT NULL,
    "ticket_id" INTEGER NOT NULL,
    "waiver_id" INTEGER,
    FOREIGN KEY("booking_id") REFERENCES "bookings"("id") ON DELETE CASCADE,
    FOREIGN KEY("ticket_id") REFERENCES "race_tickets"("id") ON DELETE CASCADE,
    FOREIGN KEY("waiver_id") REFERENCES "waivers"("id") ON DELETE SET NULL
);

--view to show info on non-expired waivers
CREATE VIEW "active_waivers" AS
SELECT waivers.id AS "waiver_id", first_name, last_name, email, signed_date AS "signed", end_date AS "expires" FROM waivers
JOIN people ON people.id = waivers.person_id
WHERE end_date > CURRENT_DATE ORDER BY signed_date DESC;

--view to show reader friendly info on bookings
CREATE VIEW "booking_info" AS
SELECT bookings.id AS "booking_id", last_name AS "booking_holder", tickets_booked, race_time, booking_date FROM bookings
JOIN people ON people.id = bookings.booking_holder_id
ORDER BY booking_date DESC, race_time;

--view to show all tickets added to a booking
CREATE VIEW "booking_contents" AS
SELECT bookings.id AS "booking_id", booking_date, name AS "ticket", number_of_laps, price AS "price_per_ticket", COUNT(name) AS "tickets_bought" FROM bookings
JOIN booking_tickets ON booking_tickets.booking_id = bookings.id
JOIN race_tickets ON race_tickets.id = booking_tickets.ticket_id
GROUP BY name;

--view to show all the people linked to a booking via their waivers
CREATE VIEW "booking_people" AS
SELECT bookings.id AS "booking_id", booking_date, first_name, last_name, age FROM people
JOIN waivers ON waivers.person_id = people.id
JOIN booking_tickets ON booking_tickets.waiver_id = waivers.id
JOIN bookings ON bookings.id = booking_tickets.booking_id;

--creating indexs where needed
CREATE INDEX people_index ON people (last_name, email);

CREATE INDEX waiver_index ON waivers (end_date);

CREATE INDEX ticket_index ON race_tickets (name);

CREATE INDEX booking_date_index ON bookings (booking_date);

CREATE INDEX booking_racetime_index ON bookings (race_time);

CREATE INDEX booking_ticket_index ON booking_tickets (booking_id, ticket_id, waiver_id);


--adding some data to fill the database

--adding people into the database
INSERT INTO people (first_name, last_name, age, email, phone_number)
VALUES
('Alice', 'Johnson', 29, 'alice.johnson@example.com', '262-555-1234'),
('Bob', 'Smith', 34, 'bob.smith@example.com', '414-555-5678'),
('Carol', 'Williams', 42, 'carol.williams@example.com', '807-555-8765'),
('David', 'Brown', 51, 'david.brown@example.com', '657-555-4321'),
('Eva', 'Davis', 23, 'eva.davis@example.com', '342-555-3456'),
('Frank', 'Miller', 37, 'frank.miller@example.com', '121-555-6789'),
('Grace', 'Wilson', 28, 'grace.wilson@example.com', '800-555-2345'),
('Hannah', 'Moore', 30, 'hannah.moore@example.com', '786-555-7890'),
('Ian', 'Taylor', 45, 'ian.taylor@example.com', '456-555-3456'),
('Judy', 'Anderson', 39, 'judy.anderson@example.com', '079-555-8901');

--adding waivers for all the people
INSERT INTO waivers (person_id, signed_date, end_date)
VALUES
(1, '2023-09-18', '2024-09-18'),
(2, '2024-05-29', '2025-05-29'),
(3, '2024-02-03', '2025-02-03'),
(4, '2024-09-04', '2025-09-04'),
(5, '2022-12-22', '2023-12-22'),
(6, '2024-04-03', '2025-04-03'),
(7, '2024-02-13', '2025-02-13'),
(8, '2024-08-09', '2025-08-09'),
(9, '2024-08-06', '2025-08-06'),
(10, '2022-10-19', '2023-10-19');

--adding tickets to sell
INSERT INTO race_tickets (name, number_of_laps, price)
VALUES
('standard_race', 12, 34.50),
('extended_race', 25, 44.50),
('grand_prix', 50, 60.00),
('late_night_deal', 12, 24.50),
('group_rate', 12, 28.00),
('extended_group_rate', 25, 36.50);
