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

-- Monthly Analysis
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

-- Timeslot Analysis
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
-- Regional Analysis
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

-- Provincial Analysis
SELECT
	Province,
	COUNT(*) AS CancelationCount
FROM
	Appointments
	JOIN Clinics ON Appointments.ClinicID = Clinics.ClinicID
WHERE
	Status = 'Cancel'
GROUP BY
	Province
ORDER BY
	CancelationCount DESC;

-- City Analysis
SELECT
	City,
	COUNT(*) AS CancelationCount
FROM
	Appointments
	JOIN Clinics ON Appointments.ClinicID = Clinics.ClinicID
WHERE
	Status = 'Cancel'
GROUP BY
	City
ORDER BY
	CancelationCount DESC
LIMIT 50;

-- Hospital Analysis
SELECT
	HospitalName,
	COUNT(*) AS CancelationCount
FROM
	Appointments
	JOIN Clinics ON Appointments.ClinicID = Clinics.ClinicID
WHERE
	Status = 'Cancel'
GROUP BY
	HospitalName
ORDER BY
	CancelationCount DESC
LIMIT 50;


