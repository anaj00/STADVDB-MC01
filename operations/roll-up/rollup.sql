-- Number of appointments per city
SELECT
    c.City,
    c.Province,
    c.RegionName,
    COUNT(a.apptid) AS AppointmentsCount
FROM
    clinics c
JOIN
    appointments a ON c.clinicid = a.clinicid
GROUP BY
    c.City, c.Province, c.RegionName;

-- Number of appointments per province
SELECT
    c.Province,
    c.RegionName,
    COUNT(a.apptid) AS AppointmentsCount
FROM
    clinics c
JOIN
    appointments a ON c.clinicid = a.clinicid
GROUP BY
    c.City, c.Province, c.RegionName;

-- Number of appointments per region
SELECT
    c.RegionName,
    COUNT(a.apptid) AS AppointmentsCount
FROM
    clinics c
JOIN
    appointments a ON c.clinicid = a.clinicid
GROUP BY
    c.RegionName;

-- Number of patients per age
SELECT 
  px.age,
  COUNT(px.pxid) AS num_patients
FROM px
WHERE px.age BETWEEN 0 AND 100
GROUP BY px.age;

-- Number of patients per age group
SELECT 
  CASE 
    WHEN px.age BETWEEN 0 AND 14 THEN 'Children'
    WHEN px.age BETWEEN 15 AND 24 THEN 'Youth'
    WHEN px.age BETWEEN 25 AND 44 THEN 'Adults'
    WHEN px.age BETWEEN 45 AND 64 THEN 'Middle-aged Adults'
    WHEN px.age BETWEEN 65 AND 100 THEN 'Seniors'
  END AS age_group,
  COUNT(px.pxid) AS num_patients
FROM px
GROUP BY age_group;