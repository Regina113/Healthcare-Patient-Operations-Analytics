-- Check for Null Values
SELECT *
FROM Patients
WHERE Patient_ID IS NULL
OR First_Name IS NULL
OR Last_Name IS NULL;

SELECT *
FROM Doctors
WHERE Doctor_ID IS NULL OR Specialization IS NULL;

SELECT *
FROM Appointments
WHERE Appointment_ID IS NULL
OR Patient_ID IS NULL
OR Doctor_ID IS NULL;

SELECT *
FROM Treatments
WHERE Treatment_ID IS NULL OR Appointment_ID IS NULL;

SELECT *
FROM Billing
WHERE Bill_ID IS NULL OR Treatment_ID IS NULL;

-- Duplicate Checks 
-- Duplicate Patients
SELECT
     First_Name,
     Last_Name,
     Date_Of_Birth,
     COUNT(*) AS Duplicate_Count
FROM Patients
GROUP BY First_Name, Last_Name, Date_Of_Birth
HAVING COUNT(*) > 1;

-- Duplicate Emails
SELECT 
      Email,
      COUNT(*) AS Duplicate_Count
FROM Patients
GROUP BY Email
HAVING COUNT(*) > 1;

SELECT
     Email,
     Patient_ID,
     First_Name,
     Last_Name,
     Date_Of_Birth
FROM Patients
WHERE Email IN (
      SELECT Email
      FROM Patients
      GROUP BY Email
      HAVING COUNT(*) > 1
)
ORDER BY Email;

SELECT 
     First_Name,
     Last_Name,
     Date_Of_Birth,
     COUNT(*) AS Duplicate_Count
FROM Patients
GROUP BY First_Name, Last_Name, Date_Of_Birth
HAVING COUNT(*) > 1;

-- Duplicate Doctors
SELECT 
     First_Name,
     Last_Name,
     Specialization,
     COUNT(*) AS Duplicate_Count
FROM Doctors
GROUP BY First_Name, Last_Name, Specialization
HAVING COUNT(*) > 1;

-- Referential Integrity Checks 
-- Appointments Without Patients
SELECT a.*
FROM Appointments a
LEFT JOIN Patients p ON a.Patient_ID = p.Patient_ID
WHERE p.Patient_ID IS NULL;

-- Appointments Without Doctors
SELECT a.*
FROM Appointments a LEFT JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
WHERE d.Doctor_ID IS NULL;

-- Treatments Without Appointments
SELECT t.*
FROM Treatments t LEFT JOIN Appointments a ON t.Appointment_ID = a.Appointment_ID
WHERE a.Appointment_ID IS NULL;

-- Bills Without Treatments
SELECT b.*
FROM Billing b LEFT JOIN Treatments t ON b.Treatment_ID = t.Treatment_ID
WHERE t.Treatment_ID IS NULL;

-- Domain/Business Rule Checks 
-- Invalid Gender Values
SELECT DISTINCT Gender
FROM Patients;

-- Invalid Appointment Statuses 
SELECT DISTINCT Status
FROM Appointments;

-- Negative Treatment Costs
SELECT *
FROM Treatments
WHERE Cost < 0;

-- Negative Billing Amounts
SELECT *
FROM Billing
WHERE Amount < 0;

-- Unrealistic Doctor Experience 
SELECT *
FROM Doctors
WHERE Years_Experience < 0 OR Years_Experience > 60;

-- Date Quality Checks
-- Future Appointment Dates
SELECT *
FROM Appointments
WHERE Appointment_Date > CURDATE();

-- Patients Registered Before Birth
SELECT *
FROM Patients
WHERE Registration_Date < Date_Of_Birth;

-- Treatment Before Appointment
SELECT 
     t.Treatment_ID,
     t.Treatment_Date,
     a.Appointment_Date
FROM Treatments t JOIN Appointments a 
ON t.Appointment_ID = a.Appointment_ID
WHERE t.Treatment_Date < a.Appointment_Date;

-- Outlier Checks 
-- Highest Treatment Costs
SELECT *
FROM Treatments
ORDER BY Cost DESC;

-- Highest Bills
SELECT *
FROM Billing 
ORDER BY Amount DESC;

-- Data Consistency Checks 
-- Billing vs Treatment Cost Mismatch 
SELECT 
     b.Bill_ID,
     b.Amount,
     t.Cost
FROM Billing b JOIN Treatments t ON b.Treatment_ID = t.Treatment_ID
WHERE b.Amount <> t.Cost;

-- Data Cleaning & Standardization
-- Standardize Gender Values 
SET SQL_SAFE_UPDATES = 0;

SELECT DISTINCT Gender 
FROM Patients;

ALTER TABLE Patients
MODIFY COLUMN Gender VARCHAR(10);

UPDATE Patients
SET Gender = 
    CASE 
        WHEN Gender = 'M' THEN 'Male'
		WHEN Gender = 'F' THEN 'Female'
		ELSE Gender 
	END;

-- Trim Whitespace
UPDATE Patients
SET
    first_name = TRIM(first_name),
    last_name = TRIM(last_name),
    email = TRIM(email),
    insurance_provider = TRIM(insurance_provider);
    
UPDATE Doctors 
SET
   first_name = TRIM(first_name),
   last_name = TRIM(last_name),
   specialization = TRIM(specialization),
   hospital_branch = TRIM(hospital_branch);
   
UPDATE Appointments
SET
   reason_for_visit = TRIM(reason_for_visit),
   status = TRIM(status);
   
-- Derived Columns
-- Add and Populate Patient Age
ALTER TABLE Patients
ADD COLUMN Age INT;

UPDATE Patients
SET Age = TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE());

-- Create and Populate Age Groups
ALTER TABLE Patients
ADD COLUMN Age_Group VARCHAR(20);

UPDATE Patients
SET Age_Group = 
    CASE
        WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 35 THEN '18-35'
        WHEN Age BETWEEN 36 AND 50 THEN '36-50'
        WHEN Age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+'
	END;
    
-- Create Revenue-Friendly Date Columns 
-- Extract Appointment Year/Month
ALTER TABLE Appointments 
ADD COLUMN Appointment_Year INT,
ADD COLUMN Appointment_Month VARCHAR(20);

UPDATE Appointments
SET
   Appointment_Year = YEAR(Appointment_Date),
   Appointment_Month = MONTHNAME(Appointment_Date);

-- Final Validation Checks 
SELECT DISTINCT Gender FROM Patients;
SELECT DISTINCT Status FROM Appointments;
SELECT DISTINCT Payment_Status FROM Billing;