SELECT pxid, status, StartTime, EndTime
FROM appointments;

SELECT DISTINCT(status)
FROM appointments;

SELECT COUNT(pxid) as 'number of null StartTime', status
FROM appointments
WHERE StartTime IS NULL
GROUP BY status;

SELECT 
    status,
    SUM(CASE WHEN StartTime IS NULL THEN 1 ELSE 0 END) AS 'number of null StartTime',
    SUM(CASE WHEN EndTime IS NULL THEN 1 ELSE 0 END) AS 'number of null EndTime',
	(SUM(CASE WHEN StartTime IS NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN EndTime IS NULL THEN 1 ELSE 0 END)) AS 'difference'
FROM 
    appointments
GROUP BY 
    status;	

SELECT
	status,
    AVG(TIMESTAMPDIFF(MINUTE, StartTime, EndTime)) AS 'Average Time Difference (minutes)'
FROM
	appointments
WHERE
	StartTime IS NOT NULL OR EndTime IS NOT NULL
GROUP BY
	status;
    

