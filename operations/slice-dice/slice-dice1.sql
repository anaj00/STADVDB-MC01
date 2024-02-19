SELECT * 
FROM appointments;

-- initial query
SELECT pxid, type, isVirtual
FROM appointments; 

-- aggregates of values based on is virtual
SELECT COUNT(pxid) as 'Amount', isVirtual
FROM appointments
GROUP BY isVirtual;

SELECT count(pxid) as 'Amount' , type
FROM appointments
GROUP BY type;

SELECT COUNT(pxid) AS 'Amount', isVirtual, type
FROM appointments
GROUP BY isVirtual, type;