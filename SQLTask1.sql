CREATE DATABASE Project;
SELECT * from orders;

-- IDENTIFYING AND DELETING DUPLICATE ORDER ID RECORDS
SELECT Order_ID, count(*) AS duplicate_count
from orders
group by Order_ID
having count(*) > 1;
SELECT * from routes;

-- REPLACING NULL TRAFFIC DELAY MIN WITH AVERAGE DELAY FOR THAT ROUTE
SET SQL_SAFE_UPDATES = 0;
UPDATE Routes
SET Traffic_Delay_Min = (
    SELECT AVG(Traffic_Delay_Min)
)
WHERE Traffic_Delay_Min IS NULL;
SELECT * from deliveryagents;
SELECT * from shipment_tracking;
SELECT * from warehouses;
SELECT * FROM shipment_tracking;

-- CONVERTING DATE COLUMNS INTO YYYY-MM-DD FORMAT:
update orders
set Order_Date = date_format(Order_Date,'%Y-%m-%d'); 

-- ENSURING THAT NO ACTUAL DELIVERY DATE IS BEFORE ORDER DATE
ALTER TABLE orders ADD COLUMN Invalid_Date_Flag TINYINT(1) DEFAULT 0;
UPDATE orders
SET Invalid_Date_Flag = 1
WHERE Actual_Delivery_Date < Order_Date;
SELECT * FROM orders WHERE Invalid_Date_Flag = 0;















