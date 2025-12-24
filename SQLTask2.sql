-- TASK 2:

-- DELIVERY DELAY IN DAYS FOR EACH ORDER
SELECT Order_ID, 
DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) AS Delivery_Delay_In_Days
FROM Orders;

ALTER TABLE orders ADD COLUMN Delivery_Delay_In_Days INT(10);
UPDATE orders
SET Delivery_Delay_In_Days = DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date);


-- TOP 10 DELAYED ROUTES BASED ON AVERAGE DELAY DAYS:
SELECT Route_ID, AVG(DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date)) AS Avg_Delay_Days
FROM Orders
GROUP BY Route_ID
ORDER BY Avg_Delay_Days DESC LIMIT 10;

-- WINDOW FUNCTION TO RANK ALL ORDERS BY DELAY WITHIN EACH WAREHOUSE:
SELECT Order_ID, Warehouse_ID,
rank() OVER (PARTITION BY Warehouse_ID ORDER BY Delivery_Delay_In_Days) AS DelayRank_inWarehouse
FROM Orders;