-- TASK 3:
SELECT Route_ID, AVG(DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date)) AS AvgDeliveryTime
FROM Orders
GROUP BY Route_ID;

-- AVERAGE TRAFFIC DELAY PER ROUTE:
SELECT Route_ID, AVG(Traffic_Delay_Min) AS AvgTrafficDelay
FROM Routes
GROUP BY Route_ID;

-- DISTANCE TO TIME EFFICIENCY RATIO:
SELECT Route_ID,
ROUND( AVG(Distance_KM) /  AVG(Average_Travel_Time_Min), 2) AS Distance_To_Time_Efficiency_Ratio
FROM Routes
GROUP BY Route_ID
ORDER BY Distance_To_Time_Efficiency_Ratio DESC;

-- 3 ROUTES WITH WORST EFFICIENCY RATIO:
SELECT Route_ID, ROUND( AVG(Distance_KM) /  AVG(Average_Travel_Time_Min), 2) AS Worst_Efficiency_Ratio
FROM Routes group by Route_ID
ORDER BY Worst_Efficiency_Ratio ASC LIMIT 3;

-- ROUTES WITH >20% DELAYED SHIPMENTS:
SELECT Route_ID,
COUNT(*) AS TotalOrders,
SUM(CASE WHEN Delivery_Status = 'Delayed' THEN 1 ELSE 0 END) AS DelayedCount,
ROUND( SUM(CASE WHEN Delivery_Status = 'Delayed' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS DelayPercent
FROM Orders
GROUP BY Route_ID
HAVING DelayPercent > 20;

WITH Route_Metrics AS (
    -- Calculate Efficiency Ratio and Delay Percentage for each route
    SELECT
        r.Route_ID,
        -- Efficiency Ratio: Higher is better
        (r.Distance_KM / NULLIF(r.Average_Travel_Time_Min, 0)) AS Efficiency_Ratio,
        -- Delay Percentage: Higher is worse
        (SUM(CASE WHEN o.Delivery_Status = 'Delayed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Delay_Percentage
    FROM
        Routes r
    JOIN
        Orders o ON r.Route_ID = o.Route_ID
    GROUP BY
        r.Route_ID, r.Distance_KM, r.Average_Travel_Time_Min
)
SELECT
    Route_ID,
    -- Rounding for cleaner output
    ROUND(Efficiency_Ratio, 4) AS Efficiency_Ratio,
    ROUND(Delay_Percentage, 2) AS Delay_Percentage,
    'High Priority: Investigate congestion, re-route options, or specific traffic delay causes.' AS Optimization_Recommendation
FROM
    Route_Metrics
WHERE
    -- 1. Routes with a high delay percentage (using the >20% criterion from previous step)
    Delay_Percentage > 20
    AND
    -- 2. Routes with efficiency below the overall average efficiency (to confirm poor performance)
    Efficiency_Ratio < (SELECT AVG(Efficiency_Ratio) FROM Route_Metrics WHERE Efficiency_Ratio IS NOT NULL)
ORDER BY
    Efficiency_Ratio ASC, -- Worst efficiency first
    Delay_Percentage DESC; -- Highest delay first
