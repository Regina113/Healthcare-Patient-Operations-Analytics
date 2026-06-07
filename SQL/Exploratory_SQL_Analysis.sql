-- Exploratory SQL Analysis
-- Patient Analytics
-- Total Patients 
SELECT COUNT(*) AS Total_Patients 
FROM Patients;

-- Patients by Gender 
SELECT 
     Gender,
     COUNT(*) AS Patient_Count
FROM Patients 
GROUP BY Gender 
ORDER BY Patient_Count DESC;

-- Patients by Age Group
SELECT 
     Age_Group,
     COUNT(*) AS Patient_Count
FROM Patients 
GROUP BY Age_Group
ORDER BY Patient_Count DESC;

-- Insurance Provider Distribution
SELECT 
      Insurance_Provider,
      COUNT(*) AS Patient_Count
FROM Patients 
GROUP BY Insurance_Provider 
ORDER BY Patient_Count DESC;

-- Most Recently Registered Patients 
SELECT 
     Patient_ID,
     First_Name,
     Last_Name,
     Registration_Date
FROM Patients 
ORDER BY Registration_Date DESC
LIMIT 10;

-- Doctor Analytics 
-- Number of Doctors per Specialization
SELECT 
     Specialization,
     COUNT(*) AS Doctor_Count
FROM Doctors 
GROUP BY Specialization
ORDER BY Doctor_Count DESC;

-- Average Doctor Experience by Specialization
SELECT 
     Specialization,
     AVG(Years_Experience) AS Avg_Experience 
FROM Doctors 
GROUP BY Specialization
ORDER BY Avg_Experience DESC;

-- Doctors with Highest Experience
SELECT 
     Doctor_ID,
     First_Name,
     Last_Name,
     Specialization,
     Years_Experience
FROM Doctors 
ORDER BY Years_Experience DESC;

-- Doctors by Hospital Branch 
SELECT 
     Hospital_Branch,
     COUNT(*) AS Doctor_Count
FROM Doctors 
GROUP BY Hospital_Branch 
ORDER BY Doctor_Count DESC;

-- Appointment Analytics
-- Total Appointments
SELECT COUNT(*) AS Total_Appointments
FROM Appointments;

-- Appointment Status Breakdown
SELECT 
     Status,
     COUNT(*) AS Appointment_Count
FROM Appointments
GROUP BY Status 
ORDER BY Appointment_Count DESC;

-- Most Common Visit Reasons 
SELECT 
     Reason_For_Visit,
     COUNT(*) AS Visit_Count
FROM Appointments
GROUP BY Reason_For_Visit
ORDER BY Visit_Count DESC
LIMIT 10;

-- Busiest Appointment Months 
SELECT
     Appointment_Month,
     COUNT(*) AS Appointment_Count
FROM Appointments 
GROUP BY Appointment_Month
ORDER BY Appointment_Count DESC;

-- Patients with Most Appointments 
SELECT 
      p.Patient_ID,
      p.First_Name,
      p.Last_Name,
      COUNT(a.Appointment_ID) AS Total_Appointments
FROM Patients p JOIN Appointments a ON p.Patient_ID = a.Patient_ID 
GROUP BY p.Patient_ID, p.First_Name, p.Last_Name
ORDER BY Total_Appointments DESC
LIMIT 10;

-- Doctors with Highest Appointment Volume 
SELECT 
     d.Doctor_ID,
     d.First_Name,
     d.Last_Name,
     d.Specialization,
     COUNT(a.Appointment_ID) AS Appointment_Count
FROM Doctors d JOIN Appointments a on d.Doctor_ID = a.Doctor_ID 
GROUP BY d.Doctor_ID, d.First_Name, d.Last_Name, d.Specialization
ORDER BY Appointment_Count DESC;

-- Treatment Analytics
-- Most Common Treatments 
SELECT 
     Treatment_Type,
     COUNT(*) AS Treatment_Count
FROM Treatments 
GROUP BY Treatment_Type
ORDER BY Treatment_Count DESC;

-- Average Treatment Cost 
SELECT 
     ROUND(AVG(Cost), 2) AS Avg_Treatment_Cost
FROM Treatments;

-- Most Expensive Treatments
SELECT 
     Treatment_ID,
     Treatment_Type,
     Cost
FROM Treatments 
ORDER BY Cost DESC
LIMIT 10;

-- Revenue by Treatment Type
SELECT 
     Treatment_Type,
     ROUND(SUM(Cost), 2) AS Total_Revenue
FROM Treatments 
GROUP BY Treatment_Type
ORDER BY Total_Revenue DESC;

-- Billing & Revenue Analytics
-- Total Revenue 
SELECT 
     ROUND(SUM(Amount), 2) AS Total_Revenue 
FROM Billing;

-- Revenue by Payment Status 
SELECT 
     Payment_Status,
     ROUND(SUM(Amount), 2) AS Total_Amount
FROM Billing
GROUP BY Payment_Status;

-- Revenue by Payment Method
SELECT 
     Payment_Method,
     ROUND(SUM(Amount), 2) AS Total_Revenue
FROM Billing
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;

-- Highest Bills
SELECT 
     Bill_ID,
     Amount,
     Payment_Status
FROM Billing
ORDER BY Amount DESC
LIMIT 10;

-- Monthly Revenue Trend 
SELECT 
     MONTHNAME(Bill_Date) AS Billing_Month,
     ROUND(SUM(Amount), 2) AS Monthly_Revenue
FROM Billing
GROUP BY Billing_Month
ORDER BY Monthly_Revenue DESC;

-- Operational Insights
-- Revenue Generated per Doctor 
SELECT
     d.Doctor_ID,
     d.First_Name,
     d.Last_Name, 
     d.Specialization,
     ROUND(SUM(t.Cost), 2) AS Total_Revenue
FROM Doctors d JOIN Appointments a ON d.Doctor_ID = a.Doctor_ID 
               JOIN Treatments t ON a.Appointment_ID = t.Appointment_ID
GROUP BY d.Doctor_ID, d.First_Name, d.Last_Name, d.Specialization
ORDER BY Total_Revenue DESC;

-- Revenue by Hospital Branch 
SELECT 
      d.Hospital_Branch,
      ROUND(SUM(t.Cost), 2) AS Total_Revenue 
FROM Doctors d JOIN Appointments a ON d.Doctor_ID = a.Doctor_ID
               JOIN Treatments t ON a.Appointment_ID = t.Appointment_ID
GROUP BY d.Hospital_Branch 
ORDER BY Total_Revenue DESC;

-- Appointment Completion Rate
SELECT 
     ROUND(SUM(CASE
                  WHEN Status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Completion_Rate_Percentage 
FROM Appointments;

-- No-Show Rate
SELECT
     ROUND(SUM(CASE
                  WHEN Status = 'No-Show' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS No_Show_Rate_Percentage
FROM Appointments;