1.
use galaxycinema;
SELECT name, length_min
FROM film
WHERE length_min > 100

2.
SELECT *
FROM film
WHERE length_min>(
	SELECT AVG(length_min) FROM film
	);
3.
SELECT *
FROM film 
WHERE name LIKE 't%';

4.
SELECT *
FROM film 
WHERE name LIKE '%a%';

5.
SELECT *
FROM film 
WHERE country ='US';

6. 
SELECT *
FROM film
WHERE length_min = (SELECT MIN(length_min) FROM film)
   OR length_min = (SELECT MAX(length_min) FROM film);

7.
SELECT genre
FROM film
GROUP BY genre;

8.
SELECT film_id, MAX(DATE(start_time)) - MIN(DATE(start_time)) AS distance
FROM screening
GROUP BY film_id;

9.
SELECT film.name as 'Film_Name',room.name as 'room_name', screening.start_time
FROM screening
JOIN film ON screening.film_id=film.film_id
JOIN room ON screening.room_id=room.room_id
WHERE film.name = 'Tom&Jerry';

10.
USE galaxycinema;
SELECT *
FROM screening
WHERE start_time NOT IN ('2022-05-25 10:00:00', '2022-05-25 08:00:00');

10.1
SELECT *
FROM screening
WHERE start_time IN ('2022-05-25 10:00:00', '2022-05-25 08:00:00');

11.
SELECT name
FROM customer
JOIN booking ON booking.customer_id = customer.customer_id
JOIN reserved_seat ON reserved_seat.booking_id=booking.booking_id
GROUP BY customer.name, booking.booking_id
HAVING COUNT(reserved_seat.booking_id)>1;

12.
SELECT name
FROM room
JOIN screening ON room.room_id=screening.room_id
GROUP BY room.name HAVING COUNT(DATE(start_time))>2;

13.
SELECT room.name, room.room_id, MAX(screening.start_time) AS last_film
FROM room
JOIN screening ON room.room_id= screening.room_id
GROUP BY room.room_id, room.name
ORDER BY last_film DESC
LIMIT 1;

14.
SELECT name
FROM film
LEFT JOIN screening ON film.film_id = screening.film_id
LEFT JOIN booking ON screening.screening_id=booking.screening_id
WHERE booking.booking_id IS NULL;

15.
SELECT film.name, COUNT(screening.film_id) AS biggest_num
FROM film
JOIN screening ON film.film_id = screening.film_id
JOIN room ON screening.room_id = room.room_id
GROUP BY film.name
ORDER BY biggest_num DESC
LIMIT 1;

16.
USE galaxycinema;
SELECT DAYNAME(start_time) AS day_of_week, COUNT(DISTINCT film_id) AS number_of_films
FROM screening
GROUP BY day_of_week
ORDER BY number_of_films DESC;

17.
SELECT film.name, SUM(length_min) as Total_mins
FROM film
JOIN screening ON screening.film_id=film.film_id
WHERE DATE(start_time)='2022-05-28'
GROUP BY film.name
ORDER BY Total_mins DESC;

18.
USE galaxycinema;
SELECT film.name, AVG(length_min) AS AVG_mins
FROM film
JOIN screening ON screening.film_id = film.film_id
GROUP BY film.name
HAVING AVG_mins > (
    SELECT AVG(length_min) FROM film
);

18.1
SELECT film.name, AVG(length_min) AS AVG_mins
FROM film
JOIN screening ON screening.film_id = film.film_id
GROUP BY film.name
HAVING AVG_mins < (
    SELECT AVG(length_min) FROM film
);

19.
SELECT room.name, seat.room_id, MIN(reserved_seat.seat_id) as Least_seat
FROM seat
JOIN reserved_seat ON seat.seat_id=reserved_seat.seat_id
JOIN room ON seat.room_id = room.room_id
GROUP BY room.name, seat.room_id
ORDER BY Least_seat DESC
LIMIT 1;

