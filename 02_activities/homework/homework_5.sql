-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

SELECT 
    v.vendor_name,
    p.product_name,
    5 * (p.cost_to_customer_per_qty) AS potential_revenue_per_product
FROM 
    vendor_inventory v
CROSS JOIN 
    product p
JOIN 
    vendor v ON v.vendor_id = p.vendor_id  -- Ensure the vendor_id is matched to get vendor names
ORDER BY 
    v.vendor_name, 
    p.product_name;


-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

CREATE TABLE product_units AS
SELECT 
    *,
    CURRENT_TIMESTAMP AS snapshot_timestamp
FROM 
    product
WHERE 
    product_qty_type = 'unit';


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO product_units (product_id, product_name, product_size, product_qty_type, cost_to_customer_per_qty, snapshot_timestamp)
VALUES (101, 'Apple Pie', '1 pie', 'unit', 12.99, CURRENT_TIMESTAMP);


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE FROM product_units
WHERE product_name = 'Apple Pie' AND product_qty_type = 'unit';



-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units

 ALTER TABLE  product_units
 ADD current_quantity INT;

ADD current_quantity INT;

UPDATE product_units
SET current_quantity = 5;  -- Set to your desired quantity for all products.
UPDATE product_units
SET current_quantity = 10  -- Set this to the desired quantity
WHERE product_name = 'Apple Pie';  -- Adjust the condition as needed.


Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */

UPDATE product_units
SET current_quantity = (
    SELECT COALESCE(v.current_quantity, 0)  -- Replace NULL with 0
    FROM vendor_inventory v
    WHERE v.product_id = product_units.product_id
    ORDER BY v.timestamp_column DESC  -- Assuming there is a timestamp or id to determine the last entry
    LIMIT 1  -- Get only the last quantity
)
WHERE product_id IN (SELECT product_id FROM vendor_inventory);  -- Ensuring only products in vendor_inventory are updated

