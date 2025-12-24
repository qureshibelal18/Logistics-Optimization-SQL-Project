-- TOP 3 WAREHOUSES WITH THE HIGHEST AVERAGE PROCESSING TIME
SELECT Warehouse_ID, Location, Processing_Time_Min
FROM warehouses
ORDER BY Processing_Time_Min DESC
LIMIT 3;

-- TOTAL VS DELAYED SHIPMENTS OF EACH WAREHOUSE
SELECT Warehouse_ID, COUNT(*) AS TotalOrders,
SUM(CASE WHEN Delivery_Status = 'Delayed' THEN 1 ELSE 0 END) AS DelayedOrders,
ROUND(SUM(CASE WHEN Delivery_Status = 'Delayed' THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS DelayPercent
FROM Orders
GROUP BY Warehouse_ID
ORDER BY DelayPercent DESC;

-- CTE: BOTTLENECK WAREHOUSES WHERE PROCESSING_TIME_MIN > GLOBAL AVG
WITH global_avg AS(
SELECT AVG(Processing_Time_Min) AS GlobalAvg FROM warehouses
)
SELECT w.Warehouse_ID, w.Location,
w.Processing_Time_Min, ga.GlobalAvg
FROM Warehouses w
CROSS JOIN global_avg ga
WHERE w.Processing_Time_Min > ga.GlobalAvg;

-- RANKING WAREHOUSES BY ON-TIME DELIVERY %
SELECT Warehouse_ID,
ROUND(SUM(CASE WHEN Delivery_Status = 'On Time'THEN 1 ELSE 0 END)/COUNT(*)*100,2)
AS OnTimeDeliveryPercent,
RANK() OVER (ORDER BY SUM(CASE WHEN Delivery_Status = 'On Time' THEN 1 ELSE 0 END)/COUNT(*)DESC)
AS OnTimeDeliveryRank
FROM orders
GROUP BY Warehouse_ID;