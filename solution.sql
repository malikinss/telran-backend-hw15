/*
Tracks with album and artist
  - Track name
  - Album title
  - Artist name
*/
SELECT 
	t.name AS track,
	al.title AS album,
	ar.name as artist
FROM track t
JOIN album al	ON t.album_id = al.album_id
JOIN artist ar	ON al.artist_id = ar.artist_id


/*
Invoice lines with track, invoice date, and customer
 - Invoice line ID
 - Invoice date
 - Track name
 - Unit price (from invoice line)
 - Quantity
 - Customer’s full name (combined first and last names)
*/
SELECT
	il.invoice_line_id,
	DATE(inv.invoice_date) AS invoice_date,
	t.name AS track,
	il.unit_price,
	il.quantity,
	CONCAT(c.first_name, ' ', c.last_name) AS customer
FROM invoice_line il
JOIN invoice inv	ON il.invoice_id = inv.invoice_id
JOIN customer c		ON inv.customer_id = c.customer_id
JOIN track t 		ON il.track_id = t.track_id

/*
Customers with their support representative (employee) sorted by full name of support representative and full name of customer
 - Customer ID
 - Customer’s full name (combined first and last names)
 - Support representative’s full name (combined first and last names)
*/
SELECT
	c.customer_id,
	CONCAT(c.first_name, ' ', c.last_name) AS customer,
	CONCAT(e.first_name, ' ', e.last_name) AS support_representative
FROM customer c
JOIN employee e	ON c.support_rep_id = e.employee_id
ORDER BY  support_representative, customer;

/*
Playlist contents: playlist name with each track sorted by playlist name and track’s name
    - Playlist's name
    - Track’s name
*/
SELECT
    pl.name AS playlist_name,
    t.name AS track_name
FROM playlist_track pl_t
JOIN playlist pl    ON pl_t.playlist_id = pl.playlist_id
JOIN track t        ON pl_t.track_id = t.track_id
ORDER BY playlist_name, track_name

/*
Invoices with billing city sorted by invoice date in descending order and Invoice ID in ascending order
    - Invoice ID
    - Invoice date
    - Billing city
    - Total
    - Customer’s full name
*/
SELECT
    inv.invoice_id,
	DATE(inv.invoice_date) as invoice_date,
    inv.billing_city,
	inv.total,
	CONCAT(c.first_name, ' ', c.last_name) as customer
FROM invoice inv
JOIN customer c ON inv.customer_id = c.customer_id
ORDER BY inv.invoice_date DESC, inv.invoice_id

/*
Employees with no manager
    - Employee’s full name
    - Title
    - Birth Date (only date with no time)
    - Hire Date (only date with no time)
*/
SELECT
    CONCAT(first_name, ' ', last_name) AS fullname,
	title,
	DATE(birth_date) AS birth_date,
	DATE(hire_date) AS hire_date, 
	reports_to
FROM employee
WHERE reports_to is NULL