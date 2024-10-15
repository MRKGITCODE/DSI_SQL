-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

SELECT v.vendor_id, 
       v.vendor_name, 
       COUNT(vba.booth_number) AS booth_rentals
FROM vendor v
INNER JOIN vendor_booth_assignments vba 
    ON v.vendor_id = vba.vendor_id
GROUP BY v.vendor_id, v.vendor_name
ORDER BY booth_rentals DESC;


/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

SELECT c.customer_id, 
       c.customer_first_name, 
       c.customer_last_name, 
       SUM(cp.total_price) AS total_spent
FROM customer c
INNER JOIN customer_purchases cp 
    ON c.customer_id = cp.customer_id
GROUP BY c.customer_id, c.customer_first_name, c.customer_last_name
HAVING SUM(cp.total_price) > 2000
ORDER BY c.customer_last_name, c.customer_first_name;




--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-- Step 1: Create the temp table and insert the original vendor data
CREATE TABLE temp.new_vendor AS 
SELECT * 
FROM vendor;


-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/

-- Step 2: Insert the new vendor into the temp.new_vendor table
INSERT INTO temp.new_vendor (vendor_name, vendor_description, vendor_owner, vendor_phone, vendor_email) 
VALUES ('mrk', 'Food store', 'razaul karim', '455-123-2376', 'eldokarim.rk@gmail.com');



-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */

SELECT 
    customer_id,
    strftime('%m', purchase_date) AS month,  -- Extract month as two digits (01-12)
    strftime('%Y', purchase_date) AS year     -- Extract year as four digits (YYYY)
FROM 
    customer_purchases;

/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */

SELECT 
    customer_id,
    SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM 
    customer_purchases
WHERE 
    strftime('%Y', purchase_date) = '2022' AND   -- Filter for the year 2022
    strftime('%m', purchase_date) = '04'          -- Filter for the month of April
GROUP BY 
    customer_id;                                   -- Group results by customer_id
