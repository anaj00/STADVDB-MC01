--base
SELECT 
  CASE 
    WHEN px.age BETWEEN 0 AND 14 THEN 'Children'
    WHEN px.age BETWEEN 15 AND 24 THEN 'Youth'
    WHEN px.age BETWEEN 25 AND 44 THEN 'Adults'
    WHEN px.age BETWEEN 45 AND 64 THEN 'Middle-aged Adults'
    WHEN px.age BETWEEN 65 AND 100 THEN 'Seniors'
  END AS age_group,
  SUM(CASE WHEN px.gender = 'MALE' THEN 1 ELSE 0 END) AS male_patients,
  SUM(CASE WHEN px.gender = 'FEMALE' THEN 1 ELSE 0 END) AS female_patients
FROM px
WHERE px.age != 'None'
GROUP BY age_group;
--improved null condition
SELECT 
  CASE 
    WHEN px.age BETWEEN 0 AND 14 THEN 'Children'
    WHEN px.age BETWEEN 15 AND 24 THEN 'Youth'
    WHEN px.age BETWEEN 25 AND 44 THEN 'Adults'
    WHEN px.age BETWEEN 45 AND 64 THEN 'Middle-aged Adults'
    WHEN px.age BETWEEN 65 AND 100 THEN 'Seniors'
  END AS age_group,
  SUM(px.gender = 'MALE') AS male_patients,
  SUM(px.gender = 'FEMALE') AS female_patients
FROM px
WHERE px.age IS NOT NULL  -- Improved null check
GROUP BY age_group;

--count of hospitals and clinics per region

SELECT 
    RegionName,
    COUNT(CASE WHEN clinics.IsHospital = 1 THEN 1 END) AS num_hospitals,
    COUNT(CASE WHEN clinics.IsHospital = 0 THEN 1 END) AS num_clinics
FROM clinics
GROUP BY RegionName

--count of total hospitals and clinics

SELECT 
    
    COUNT(CASE WHEN clinics.IsHospital = 1 THEN 1 END) AS num_hospitals,
    COUNT(CASE WHEN clinics.IsHospital = 0 THEN 1 END) AS num_clinics
FROM clinics