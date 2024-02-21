--count of patients by gender per age group
SELECT 
    age_group,
    COUNT(CASE WHEN gender = 'MALE' THEN 1 END) AS male_patients,
    COUNT(CASE WHEN gender = 'FEMALE' THEN 1 END) AS female_patients
FROM (
    SELECT 
        CASE 
            WHEN age BETWEEN 0 AND 14 THEN 'Children'
            WHEN age BETWEEN 15 AND 24 THEN 'Youth'
            WHEN age BETWEEN 25 AND 44 THEN 'Adults'
            WHEN age BETWEEN 45 AND 64 THEN 'Middle-aged Adults'
            WHEN age BETWEEN 65 AND 100 THEN 'Seniors'
        END AS age_group,
        gender
    FROM 
        px
) AS age_gender_filtered
GROUP BY 
    age_group;

--count of doctors per age group
SELECT 
  CASE 
    WHEN doctors.age BETWEEN 25 AND 44 THEN 'Adults'
    WHEN doctors.age BETWEEN 45 AND 64 THEN 'Middle-aged Adults'
    WHEN doctors.age BETWEEN 65 AND 100 THEN 'Seniors'
  END AS age_group, COUNT(doctors.doctorid) AS num_doctors
FROM doctors
GROUP BY age_group;

--count of hospitals and clinics per region

SELECT 
    RegionName,
    COUNT(CASE WHEN clinics.IsHospital = 1 THEN 1 END) AS num_hospitals,
    COUNT(CASE WHEN clinics.IsHospital = 0 THEN 1 END) AS num_clinics
FROM clinics
GROUP BY RegionName
ORDER BY num_hospitals



