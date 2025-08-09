CREATE DATABASE IF NOT EXISTS GalaxyCinema;
USE GalaxyCinema;
CREATE TABLE film (
    film_id varchar(225) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    length_min INT NOT NULL,
    genre VARCHAR(225),
    country VARCHAR(225)
);


INSERT INTO film (film_id, name, length_min, genre, country) VALUES
('FM001', 'Movie A',  120, 'Comedy', 'VN'),
('FM002', 'Movie B',  125, 'Horror', 'AU'),
('FM003', 'Movie C',  162, 'Horror', 'JP');
    
SELECT * FROM film;


-- room
CREATE TABLE room (
	room_id VARCHAR(225) PRIMARY KEY,
    name VARCHAR(225)
);

INSERT INTO room (room_id, name) VALUES
('T001', 'Threater A'),
('T002', 'Threater B'),
('T003', 'Threater C');


SELECT * FROM room;


-- screening
CREATE TABLE screening (
	screening_id VARCHAR(225) PRIMARY KEY,
    film_id varchar (225) NOT NULL,
    room_id varchar(225) NULL,
    start_time DATETIME NOT NULL,
    FOREIGN KEY (film_id) REFERENCES film(film_id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE CASCADE
);

INSERT INTO screening (screening_id, film_id, room_id, start_time) VALUES 
('SC001', 'FM003', 'T002', '2025-10-10 10:00:00'),
('SC002', 'FM002', 'T001', '2025-10-11 8:00:00'),
('SC003', 'FM002', 'T001', '2025-10-12 9:00:00'),
('SC004', 'FM001', 'T003', '2025-10-13 18:00:00');

SELECT * FROM screening;

-- seat

CREATE TABLE seat (
	seat_id VARCHAR(225) PRIMARY KEY,
    room_id VARCHAR(225) NOT NULL,
    row_char VARCHAR(225) NOT NULL,
    row_num INT NOT NULL,
    x INT,
    y INT,
    
    FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE CASCADE
);

INSERT INTO seat (seat_id, room_id, row_char, row_num, x, y) VALUES 
('S001', 'T001', 'A', 1, 1, 1),
('S002', 'T001', 'A', 5, 1, 3),
('S003', 'T002', 'G', 4, 1, 1),
('S004', 'T003', 'F', 6, 2, 1),
('S005', 'T003', 'F', 7, 3, 1);


-- customer 
CREATE TABLE customer (
	customer_id VARCHAR(225) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(100) UNIQUE 
); 


INSERT INTO customer (customer_id, name, phone) VALUES 
('C001', 'Leslie', 1234567891),
('C002', 'Noah', 1234567892),
('C003', 'Ivy', 1234567893),
('C004', 'Jayden', 1234567894),
('C005', 'Johnathan', 1234567895);


-- booking 
CREATE TABLE booking (
	booking_id VARCHAR(225) PRIMARY KEY,
    customer_id VARCHAR(225) NOT NULL,
    screening_id VARCHAR(225) NOT NULL,
    booking_time DATETIME NOT NULL,
    total INTEGER NOT NULL,
    
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (screening_id) REFERENCES screening(screening_id)
);

INSERT INTO booking (booking_id, customer_id, screening_id, booking_time, total) VALUES 
('B001', 'C001', 'SC002', '2025-10-10 8:30:00', 10),
('B002', 'C001', 'SC003', '2025-10-8 10:10:00', 10),
('B003', 'C003', 'SC004', '2025-10-11 13:53:00', 10),
('B004', 'C004', 'SC004', '2025-10-12 9:32:00', 10);



CREATE TABLE reserved_seat (
  reserved_seat_id VARCHAR(225) PRIMARY KEY,
  booking_id VARCHAR(225) NOT NULL,
  seat_id VARCHAR(225) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
  FOREIGN KEY (seat_id) REFERENCES seat(seat_id)
);

INSERT INTO reserved_seat (reserved_seat_id, booking_id, seat_id, price) VALUES 
('RS001', 'B001', 'S001', 5.50),
('RS002', 'B002', 'S002', 5.50),
('RS003', 'B003', 'S004', 10.50),
('RS004', 'B003', 'S003', 10.50),
('RS005', 'B004', 'S005', 10.50);