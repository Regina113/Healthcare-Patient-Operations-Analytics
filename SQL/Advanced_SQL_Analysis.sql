-- Advanced SQL Analytics
-- Doctor Revenue Ranking 
-- Rank Doctors by Revenue Generated
SELECT 
     d.Doctor_ID, d.First_Name, d.Last_Name, d.Specialization,
     ROUND(SUM(t.Cost), 2) AS Total_Revenue,
     RANK() OVER (ORDER BY SUM(t.Cost) DESC) AS Revenue_Rank
FROM Doctors d JOIN Appointments a ON d.Doctor_ID = a.Doctor_ID
               JOIN Treatments t ON a.Appointment_ID = t.Appointment_ID
GROUP BY d.Doctor_ID, d.First_Name, d.Last_Name, d.Specialization;

-- Dense Rank Version
SELECT d.Doctor_ID, d.First_Name, d.Last_Name, 
       ROUND(SUM(t.Cost), 2) AS Total_Revenue,
       DENSE_RANK() OVER (ORDER BY SUM(t.Cost) DESC) AS Dense_Rank_Position
FROM Doctors d JOIN Appointments a ON d.Doctor_ID = a.Doctor_ID
               JOIN Treatments t ON a.Appointment_ID = t.Appointment_ID
GROUP BY d.Doctor_ID, d.First_Name, d.Last_Name;

-- Running Revenue Totals
-- Running Hospital Revenue 
SELECT Bill_Date,
       ROUND(SUM(Amount), 2) AS Daily_Revenue,
       ROUND(SUM(SUM(Amount)) OVER (ORDER BY Bill_Date), 2) AS Running_Total_Revenue
FROM Billing
GROUP BY Bill_Date
ORDER BY Bill_Date;

-- Monthly Revenue Growth 
-- Revenue by Month
WITH Monthly_Revenue AS (
     SELECT
          YEAR(Bill_Date) AS Revenue_Year,
          MONTH(Bill_Date) AS Revenue_Month,
          ROUND(SUM(Amount), 2) AS Total_Revenue
	FROM Billing
    GROUP BY
           YEAR(Bill_Date),
           MONTH(Bill_Date)
)
SELECT *,
       LAG(Total_Revenue) OVER (ORDER BY Revenue_Year, Revenue_Month) AS Previous_Month_Revenue,
       ROUND((Total_Revenue - LAG(Total_Revenue) OVER (ORDER BY Revenue_Year, Revenue_Month)) /
       LAG(Total_Revenue) OVER (ORDER BY Revenue_Year, Revenue_Month) * 100, 2) AS Revenue_Growth_Percentage
FROM Monthly_Revenue;

-- Most Loyal Patients
-- Patients with Highest Visit Frequency 
SELECT p.Patient_ID, p.First_Name, p.Last_Name,
	   COUNT(a.Appointment_ID) AS Total_Visits,
       RANK() OVER (ORDER BY COUNT(a.Appointment_ID) DESC) AS Visit_Rank
FROM Patients p JOIN Appointments a ON p.Patient_ID = a.Patient_ID
GROUP BY p.Patient_ID, p.First_Name, p.Last_Name;

-- Average Revenue per Doctor 
SELECT 
     d.Specialization,
     ROUND(AVG(t.Cost), 2) AS Avg_Treatment_Revenue,
     ROUND(SUM(t.Cost), 2) AS Total_Specialization_Revenue
FROM Doctors d JOIN Appointments a ON d.Doctor_ID = a.Doctor_ID
               JOIN Treatments t ON a.Appointment_ID = t.Appointment_ID
GROUP BY d.Specialization
ORDER BY Total_Specialization_Revenue DESC;

-- Top 3 Highest Revenue Doctors Per Specialization
WITH Doctor_Revenue AS (
     SELECT 
          d.Specialization,
          d.Doctor_ID,
          d.First_Name,
          d.Last_Name,
          ROUND(SUM(t.Cost), 2) AS Total_Revenue,
          ROW_NUMBER() OVER (PARTITION BY d.Specialization
                             ORDER BY SUM(t.Cost) DESC) AS Row_Num
	 FROM Doctors d JOIN Appointments a ON d.Doctor_ID = a.Doctor_ID
                    JOIN Treatments t ON a.Appointment_ID = t.Appointment_ID
	 GROUP BY d.Specialization,
              d.Doctor_ID,
              d.First_Name,
              d.Last_Name
)
SELECT *
FROM Doctor_Revenue 
WHERE Row_Num <= 3;

-- Appointment Trends Over Time
SELECT
     Appointment_Date,
     COUNT(*) AS Appointments_Per_Day,
     ROUND(AVG(COUNT(*)) OVER (
           ORDER BY Appointment_Date
           ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS Rolling_7_Day_Avg
FROM Appointments
GROUP BY Appointment_Date
ORDER BY Appointment_Date;

-- Payment Status Contribution
SELECT 
     Payment_Status,
     ROUND(SUM(Amount), 2) AS Total_Amount,
     ROUND(SUM(Amount) * 100.0 / SUM(SUM(Amount)) OVER (), 2) AS Percentage_Of_Total_Revenue
FROM Billing
GROUP BY Payment_Status;

-- Patient Age Demographic Ranking 
SELECT 
      Age_Group,
      COUNT(*) AS Patient_Count,
      DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS Demographic_Rank
FROM Patients
GROUP BY Age_Group;

-- Most Profitable Treatment Types
SELECT
     Treatment_Type,
     COUNT(*) AS Treatment_Frequency,
     ROUND(SUM(Cost), 2) AS Total_Revenue,
     ROUND(AVG(Cost), 2) AS Avg_Treatment_Cost,
     RANK() OVER (ORDER BY SUM(Cost) DESC) AS Profitability_Rank
FROM Treatments
GROUP BY Treatment_Type;

-- Patient with Consecutive Appointments
SELECT
     Patient_ID,
     Appointment_Date,
     LAG(Appointment_Date) OVER (
         PARTITION BY Patient_ID
         ORDER BY Appointment_Date) AS Previous_Appointment_Date
FROM Appointments;

























































































































































































































