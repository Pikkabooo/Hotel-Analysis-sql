
-- 1. How many rooms are available in each room type ?
SELECT 
  room_type,
	COUNT(*) AS total_room,
	COUNT(
				CASE 
					WHEN status = 'available' THEN 1 
				END
			 ) AS available_room
FROM Rooms
GROUP BY room_type;


-- 2. What is the average cost customers pay for ?
SELECT
	ROUND(AVG(amount_paid)) AS average_paid
FROM Reservations;


-- 3. Which customer has spent the most money and made the most reservations?
SELECT 
	customer_id,
	SUM(amount_paid) AS total_spent ,
	COUNT(customer_id) AS total_reservation 
FROM Reservations 
GROUP BY customer_id
ORDER BY total_spent DESC 
LIMIT 1;


-- 4. Which day customers have made the most reservations?
SELECT
	CASE CAST( STRFTIME('%w', check_in_date) AS integer )  
		WHEN 0 THEN 'Sun'
		WHEN 1 THEN 'Mon'
		WHEN 2 THEN 'Tue'
		WHEN 3 THEN 'Wed'
		WHEN 4 THEN 'Thu'
		WHEN 5 THEN 'Fri'
		ELSE 'Sat' 
	END AS weekday,
	COUNT(*) AS number_of_reservation
FROM Reservations
GROUP BY weekday
ORDER BY number_of_reservation DESC;


-- 5. How much is the occupancy rate ?
SELECT 
	ROUND( ( SUM(CASE WHEN  status = 'occupied' THEN 1 ELSE 0 END) * 100 ) / ROUND(COUNT(*), 1) , 2) AS occupancy_rate
FROM Rooms;



