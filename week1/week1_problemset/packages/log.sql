
-- *** The Lost Letter ***

--Find the id of Anneke's address
SELECT id FROM addresses WHERE address = '900 Somerville Avenue';

--Find the all the info on all of the packages sent from Anneke's address
SELECT * FROM packages WHERE from_address_id = (SELECT id FROM addresses WHERE address = '900 Somerville Avenue');

--Find the id of the package sent from Anneke's address where the contents is 'Congratulatory letter'
SELECT id FROM packages WHERE from_address_id = (
    SELECT id FROM addresses WHERE address = '900 Somerville Avenue') AND contents = 'Congratulatory letter';

--Find the 'Drop' scan for the package id found above
SELECT * FROM scans WHERE package_id = (
    SELECT id FROM packages WHERE from_address_id = (
        SELECT id FROM addresses WHERE address = '900 Somerville Avenue') AND contents = 'Congratulatory letter' AND action = 'Drop');

--Find all the info about the address where the package was dropped off
SELECT * FROM addresses WHERE id = (SELECT address_id FROM scans WHERE package_id = (
    SELECT id FROM packages WHERE from_address_id = (
        SELECT id FROM addresses WHERE address = '900 Somerville Avenue') AND contents = 'Congratulatory letter' AND action = 'Drop'));


-- *** The Devious Delivery ***

--Find the all the info of the package with no from address
SELECT * FROM packages WHERE from_address_id IS NULL;

--Find the address id where the package was dropped
SELECT address_id FROM scans WHERE package_id = (
    SELECT id FROM packages WHERE from_address_id IS NULL) AND action = 'Drop';

--Find the info on the address id where the package was dropped
SELECT * FROM addresses WHERE id = (
    SELECT address_id FROM scans WHERE package_id = (
        SELECT id FROM packages WHERE from_address_id IS NULL) AND action = 'Drop');


-- *** The Forgotten Gift ***

--Find the info on the package sent to and from the given addresses
SELECT id FROM packages WHERE to_address_id = (
    SELECT id FROM addresses WHERE address = '728 Maple Place') AND from_address_id = (
        SELECT id FROM addresses WHERE address = '109 Tileston Street');

--Find the scans for the package
SELECT * FROM scans WHERE package_id = (SELECT id FROM packages WHERE to_address_id = (
    SELECT id FROM addresses WHERE address = '728 Maple Place') AND from_address_id = (
        SELECT id FROM addresses WHERE address = '109 Tileston Street'));

--Find the driver who stil has the package
SELECT name FROM drivers WHERE id = (
    SELECT driver_id FROM scans WHERE package_id = (SELECT id FROM packages WHERE to_address_id = (
        SELECT id FROM addresses WHERE address = '728 Maple Place') AND from_address_id = (
            SELECT id FROM addresses WHERE address = '109 Tileston Street')) ORDER BY timestamp DESC);
