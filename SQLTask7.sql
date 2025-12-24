
-- AVERAGE DELIVERY DELAY PER REGION(Start_Location)
SELECT r.Start_Location AS Region,
AVG(DATEDIFF(o.Actual_Delivery_Date,o.Expected_Delivery_Date)) AS
Avg_Delivery_Delay_Days
FROM Orders o
JOIN Routes r
ON o.Route_ID = r.Route_ID
GROUP BY r.Start_Location
ORDER BY Avg_Delivery_Delay_Days DESC;

-- ON-TIME DELIVERY % = (TOTAL ON-TIME DELIVERIES/TOTAL DELIVERIES)*100:
SELECT (SUM(CASE WHEN Delivery_Status = 'On Time' THEN 1 ELSE 0 END)*100.0/COUNT(*)) AS
Global_On_Time_Delivery_Percentage
FROM orders;

-- AVERAGE TRAFFIC DELAY PER ROUTE:
SELECT Route_ID,AVG(Traffic_Delay_Min) AS Avg_Traffic_Delay_Min
FROM Routes
GROUP BY Route_ID
ORDER BY Avg_Traffic_Delay_Min DESC;