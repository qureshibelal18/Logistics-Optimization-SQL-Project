-- FOR EACH ORDER LIST THE LAST CHECKPOINT AND TIME:
WITH RankedCheckpoints AS (
	SELECT Order_ID, Checkpoint, Checkpoint_Time,
    ROW_NUMBER() OVER(PARTITION BY Order_ID ORDER BY Checkpoint_Time DESC) AS rn
    FROM shipment_tracking
)
SELECT Order_ID, Checkpoint AS Last_Checkpoint, Checkpoint_Time AS Last_Checkpoint_Time
FROM RankedCheckpoints WHERE rn = 1
ORDER BY Order_ID;

-- FINDING THE MOST COMMMON DELAY REASONS(EXCLUDING NONE)
SELECT Delay_Reason, Count(*) AS Number_Of_Delays
FROM shipment_tracking
WHERE Delay_Reason IS NOT NULL AND Delay_Reason <> 'None'
GROUP BY Delay_Reason
ORDER BY Number_Of_Delays DESC;

-- IDENTIFY ORDERS WITH >2 DELAYED CHECKPOINTS
SELECT Order_ID, COUNT(*) AS Number_Of_Delayed_Checkpoints
FROM shipment_tracking
WHERE Delay_Reason IS NOT NULL AND Delay_Reason <> 'None'
GROUP BY Order_ID
HAVING COUNT(*) > 2
ORDER BY Number_Of_Delayed_Checkpoints DESC;