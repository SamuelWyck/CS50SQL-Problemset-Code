--adding a new person
INSERT INTO people (first_name, last_name, age, email, phone_number)
VALUES('Samuel', 'Rodgers', 43, 'samuel.rodgers@example.com', '274-555-9080');

--adding a waiver for that person
INSERT INTO waivers (person_id)
VALUES((SELECT id FROM people WHERE email = 'samuel.rodgers@example.com'));

--adding a booking for a race
INSERT INTO bookings (booking_holder_id, tickets_booked, race_time, booking_date)
VALUES((SELECT id FROM people WHERE email = 'samuel.rodgers@example.com'), 4, '1:30', CURRENT_DATE);

--linking the tickets to the booking and linking a waiver to each ticket
INSERT INTO booking_tickets (booking_id, ticket_id, waiver_id)
VALUES
((SELECT id FROM bookings WHERE booking_holder_id = (SELECT id FROM people WHERE email = 'samuel.rodgers@example.com') AND booking_date >= CURRENT_DATE),
(SELECT id FROM race_tickets WHERE name = 'standard_race'), (SELECT id FROM waivers WHERE person_id = (SELECT id FROM people WHERE email = 'samuel.rodgers@example.com'))),
((SELECT id FROM bookings WHERE booking_holder_id = (SELECT id FROM people WHERE email = 'samuel.rodgers@example.com') AND booking_date >= CURRENT_DATE),
(SELECT id FROM race_tickets WHERE name = 'standard_race'), (SELECT id FROM waivers WHERE person_id = (SELECT id FROM people WHERE email = 'alice.johnson@example.com'))),
((SELECT id FROM bookings WHERE booking_holder_id = (SELECT id FROM people WHERE email = 'samuel.rodgers@example.com') AND booking_date >= CURRENT_DATE),
(SELECT id FROM race_tickets WHERE name = 'extended_race'), (SELECT id FROM waivers WHERE person_id = (SELECT id FROM people WHERE email = 'judy.anderson@example.com'))),
((SELECT id FROM bookings WHERE booking_holder_id = (SELECT id FROM people WHERE email = 'samuel.rodgers@example.com') AND booking_date >= CURRENT_DATE),
(SELECT id FROM race_tickets WHERE name = 'extended_race'), (SELECT id FROM waivers WHERE person_id = (SELECT id FROM people WHERE email = 'david.brown@example.com')));


--looking to see if a person has an active waiver on file
SELECT * FROM active_waivers WHERE email = 'samuel.rodgers@example.com';

--looking up general info for an upcoming booking
SELECT * FROM booking_info WHERE booking_id = (SELECT id FROM bookings WHERE booking_holder_id = (
    SELECT id FROM people WHERE email = 'samuel.rodgers@example.com')) AND booking_date >= CURRENT_DATE;

--looking up info about tickets for a booking
SELECT * FROM booking_contents WHERE booking_id = (SELECT id FROM bookings WHERE booking_holder_id = (
    SELECT id FROM people WHERE email = 'samuel.rodgers@example.com')) AND booking_date >= CURRENT_DATE;

--looking up all the people linked to a booking
SELECT * FROM booking_people WHERE booking_id = (SELECT id FROM bookings WHERE booking_holder_id = (
    SELECT id FROM people WHERE email = 'samuel.rodgers@example.com')) AND booking_date >= CURRENT_DATE;

--looking up the tickets available for purchase
SELECT name, number_of_laps, price FROM race_tickets;

--looking up a person
SELECT * FROM people WHERE first_name = 'Samuel' AND last_name = 'Rodgers';