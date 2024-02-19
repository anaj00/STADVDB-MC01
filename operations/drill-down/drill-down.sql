SELECT * FROM appointments;

-- Yearly Analysis
SELECT
	YEAR(StartTime) AS AppointmentYear,
	COUNT(*) AS AppointmentCount
FROM
	Appointments
WHERE
	YEAR(StartTime) >= 2016 AND
	YEAR(StartTime) <= 2024
GROUP BY
	AppointmentYear
ORDER BY
	AppointmentYear;

-- Quarterly Analysis
SELECT
    YEAR(TimeQueued) AS AppointmentYear,
    QUARTER(TimeQueued) AS AppointmentQuarter,
    COUNT(*) AS AppointmentCount
FROM
    Appointments
WHERE
    YEAR(TimeQueued) >= 2016
GROUP BY
    AppointmentYear, AppointmentQuarter
ORDER BY
    AppointmentYear, AppointmentQuarter;

-- Monthly Analysis
SELECT
	YEAR(StartTime) AS AppointmentYear,
	QUARTER(StartTime) AS AppointmentQuarter,
	COUNT(*) AS AppointmentCount
FROM
	Appointments
WHERE
	YEAR(StartTime) >= 2016 AND
	YEAR(StartTime) <= 2024
GROUP BY
	AppointmentYear, AppointmentQuarter
ORDER BY
	AppointmentYear, AppointmentQuarter;
    
-- Average Monthly Analysis
SELECT
	YEAR(StartTime) AS AppointmentYear,
	MONTH(StartTime) AS AppointmentMonth,
	COUNT(*) AS TotalAppointmentCount,
	AVG(COUNT(*)) OVER (PARTITION BY MONTH(StartTime)) AS AverageAppointmentCount
FROM
	Appointments
WHERE
	YEAR(StartTime) >= 2016 AND
	YEAR(StartTime) <= 2024
GROUP BY
	AppointmentYear, AppointmentMonth
ORDER BY
	AppointmentYear, AppointmentMonth;

-- Weekly Analysis
SELECT
	YEAR(StartTime) AS AppointmentYear,
	WEEK(StartTime) AS AppointmentWeek,
	COUNT(*) AS TotalAppointmentCount,
	AVG(COUNT(*)) OVER (PARTITION BY YEAR(StartTime), WEEK(StartTime)) AS AverageAppointmentCount
FROM
	Appointments
WHERE
	YEAR(StartTime) >= 2016 AND
	YEAR(StartTime) <= 2024
GROUP BY
	AppointmentYear, AppointmentWeek
ORDER BY
	AppointmentYear, AppointmentWeek;
    
-- Average Weekly Analysis
SELECT
	AppointmentWeek,
	AVG(WeeklyCount) AS AverageAppointmentCount
FROM
	(
		SELECT
			WEEK(StartTime) AS AppointmentWeek,
			COUNT(*) AS WeeklyCount
		FROM
			Appointments
		WHERE
			YEAR(StartTime) >= 2016
		GROUP BY
			AppointmentWeek
	) AS WeeklyCounts
GROUP BY
	AppointmentWeek
ORDER BY
	AppointmentWeek;

-- Day of the Week Analysis
SELECT
	DAYNAME(MIN(StartTime)) AS AppointmentDay,
	COUNT(*) AS AppointmentCount
FROM
	Appointments
WHERE
	YEAR(StartTime) >= 2016 AND
	YEAR(StartTime) <= 2024
GROUP BY
	DAYOFWEEK(StartTime)
ORDER BY
	DAYOFWEEK(StartTime);

-- Timeslot Analysis (2016 and above)
SELECT
	CASE
		WHEN HOUR(StartTime) BETWEEN 6 AND 12 THEN 'Morning'
		WHEN HOUR(StartTime) BETWEEN 12 AND 18 THEN 'Afternoon'
		WHEN HOUR(StartTime) BETWEEN 18 AND 24 THEN 'Evening'
	END AS AppointmentTimeslot,
	COUNT(*) AS AppointmentCount
FROM
	Appointments
WHERE
	YEAR(StartTime) >= 2016
GROUP BY
	AppointmentTimeslot
ORDER BY
	AppointmentCount DESC;


-- ---------------------

-- Trend of Patients Canceling per Granularity
SELECT
    RegionName,
    COUNT(*) AS CancelationCount
FROM
    Appointments
    JOIN Clinics ON Appointments.ClinicID = Clinics.ClinicID
WHERE
    Status = 'Cancel'
GROUP BY
    RegionName
ORDER BY
    CancelationCount DESC;
    
SELECT
	HospitalName,
	COUNT(*) AS TotalAppointments,
	SUM(CASE WHEN Status = 'Cancel' THEN 1 ELSE 0 END) AS CancelledAppointments,
	SUM(CASE WHEN Status = 'Complete' THEN 1 ELSE 0 END) AS SuccessfulAppointments
FROM
	Appointments
	JOIN Clinics ON Appointments.ClinicID = Clinics.ClinicID
GROUP BY
	HospitalName
ORDER BY
	TotalAppointments DESC
LIMIT 5;
    

SELECT DISTINCT Status
FROM Appointments;


