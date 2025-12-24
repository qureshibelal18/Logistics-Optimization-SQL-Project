-- RANKING AGENTS (PER ROUTE) BY ON-TIME DELIVERY PERCENTAGE
SELECT Agent_ID, Route_ID, On_Time_Percentage,
RANK() OVER(PARTITION BY Route_ID ORDER BY On_Time_Percentage DESC)
AS Agent_Rank_Per_Route
FROM deliveryagents
ORDER BY Route_ID, Agent_Rank_Per_Route;

-- FINDING AGENTS WITH ON-TIME % < 80% 
SELECT Agent_ID, Route_ID, On_Time_Percentage
FROM deliveryagents
WHERE On_Time_Percentage < 80
ORDER BY On_Time_Percentage ASC;

-- COMPARE AVERAGE SPEED OF TOP 5 VS BOTTOM 5 AGENTS USING SUBQUERIES
SELECT 'Top 5 Agents' AS Group_Name,
AVG(Avg_Speed_KM_HR) AS Avg_Speed
FROM (SELECT Avg_Speed_KM_HR
FROM deliveryagents
ORDER BY Avg_Speed_KM_HR DESC LIMIT 5) AS TOP_AGENTS
UNION ALL
SELECT 'Bottom 5 Agents' AS Group_Name,
AVG(Avg_Speed_KM_HR) AS Avg_Speed
FROM (SELECT Avg_Speed_KM_HR
FROM deliveryagents
ORDER BY Avg_Speed_KM_HR ASC LIMIT 5) AS BOTTOM_AGENTS;