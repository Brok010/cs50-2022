-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT description FROM crime_scene_reports WHERE month = 7 AND day = 28 and street = "Humphrey Street";
--Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
--Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.
SELECT name,transcript FROM interviews WHERE month = 7 AND day = 28 AND transcript LIKE "%bakery%";

--| Raymond | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call,
--I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
--The thief then asked the person on the other end of the phone to purchase the flight ticket. |

SELECT people.name FROM people
JOIN phone_calls ON people.phone_number = phone_calls.receiver
WHERE phone_calls.caller IN (SELECT people.phone_number from atm_transactions
JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number
JOIN people ON people.id = bank_accounts.person_id
WHERE people.name IN (SELECT people.name FROM bakery_security_logs
JOIN people ON people.license_plate = bakery_security_logs.license_plate
WHERE month = 7 AND day = 28 AND hour = 10 AND minute < 26 AND activity = "exit")
AND people.name IN (SELECT name FROM people
JOIN phone_calls ON people.phone_number = phone_calls.caller
WHERE phone_calls.year = 2021 AND phone_calls.month = 7 AND phone_calls.day = 28 AND duration <= 60)
AND people.name IN (SELECT people.name FROM passengers
JOIN people ON people.passport_number = passengers.passport_number
WHERE passengers.flight_id IN (
SELECT flights.id FROM flights
JOIN airports ON airports.id = flights.origin_airport_id
WHERE city = "Fiftyville" AND month = 7 AND day = 29
ORDER BY hour ASC LIMIT 1))
AND month = 7 AND day = 28 AND atm_location = "Leggett Street")
AND phone_calls.year = 2021 AND phone_calls.month = 7 AND phone_calls.day = 28 AND duration <= 60;
--Robin has to be the accomplice



SELECT people.name from atm_transactions
JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number
JOIN people ON people.id = bank_accounts.person_id
WHERE people.name IN (SELECT people.name FROM bakery_security_logs
JOIN people ON people.license_plate = bakery_security_logs.license_plate
WHERE month = 7 AND day = 28 AND hour = 10 AND minute < 26 AND activity = "exit")
AND people.name IN (SELECT name FROM people
JOIN phone_calls ON people.phone_number = phone_calls.caller
WHERE phone_calls.year = 2021 AND phone_calls.month = 7 AND phone_calls.day = 28 AND duration <= 60)
AND people.name IN (SELECT people.name FROM passengers
JOIN people ON people.passport_number = passengers.passport_number
WHERE passengers.flight_id IN (
SELECT flights.id FROM flights
JOIN airports ON airports.id = flights.origin_airport_id
WHERE city = "Fiftyville" AND month = 7 AND day = 29
ORDER BY hour ASC LIMIT 1))
AND month = 7 AND day = 28 AND atm_location = "Leggett Street";
--| Bruce | has to be the robber


SELECT city FROM airports
JOIN flights ON flights.destination_airport_id = airports.id
WHERE flights.id IN (SELECT flights.id FROM flights
JOIN airports ON airports.id = flights.origin_airport_id
WHERE city = "Fiftyville" AND month = 7 AND day = 29
ORDER BY hour ASC LIMIT 1);
--| New York City | this is the city where he went