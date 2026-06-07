-- Create the Database
CREATE DATABASE Healthcare_Analytics;
USE Healthcare_Analytics;

-- Create the Tables
CREATE TABLE Patients (
       Patient_ID VARCHAR(10) PRIMARY KEY,
       First_Name VARCHAR(50),
       Last_Name VARCHAR(50),
       Gender CHAR(1),
       Date_Of_Birth DATE,
       Contact_Number VARCHAR(20),
       Address VARCHAR(255),
       Registration_Date DATE,
       Insurance_Provider VARCHAR(100),
       Insurance_Number VARCHAR(50),
       Email VARCHAR(100)
);

CREATE TABLE Doctors (
       Doctor_ID VARCHAR(10) PRIMARY KEY,
       First_Name VARCHAR(50),
       Last_Name VARCHAR(50),
       Specialization VARCHAR(100),
       Phone_Number VARCHAR(20),
       Years_Experience INT,
       Hospital_Branch VARCHAR(100),
       Email VARCHAR(100)
);

CREATE TABLE Appointments (
       Appointment_ID VARCHAR(10) PRIMARY KEY,
       Patient_ID VARCHAR(10),
       Doctor_ID VARCHAR(10),
       Appointment_Date DATE,
       Appointment_Time TIME,
       Reason_For_Visit VARCHAR(255),
       Status VARCHAR(50),
       
       FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
       FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

CREATE TABLE Treatments (
       Treatment_ID VARCHAR(10) PRIMARY KEY,
       Appointment_ID VARCHAR(10),
       Treatment_Type VARCHAR(100),
       Description VARCHAR(255),
       Cost DECIMAL(10,2),
       Treatment_Date DATE,
       
       FOREIGN KEY (Appointment_ID) REFERENCES Appointments(Appointment_ID)
);

CREATE TABLE Billing (
       Bill_ID VARCHAR(10) PRIMARY KEY,
       Patient_ID VARCHAR(10),
       Treatment_ID VARCHAR(10),
       Bill_Date DATE,
       Amount DECIMAL(10,2),
       Payment_Method VARCHAR(50),
       Payment_Status VARCHAR(50),
       
       FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
       FOREIGN KEY (Treatment_ID) REFERENCES Treatments(Treatment_ID)
);

-- Verify Import Counts
SELECT COUNT(*) FROM Patients;
SELECT COUNT(*) FROM Doctors;
SELECT COUNT(*) FROM Appointments;
SELECT COUNT(*) FROM Treatments;
SELECT COUNT(*) FROM Billing;