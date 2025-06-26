-- Queries to Test (DQL)


-- List all patients who visited a certain doctor.

SELECT p.Patient_Name, d.Doctor_Name
FROM Patient p
JOIN DoctorPatient dp ON p.Patient_ID = dp.Patient_ID
JOIN Doctor d ON dp.Doctor_ID = d.Doctor_ID
WHERE d.Doctor_Name = 'Dr. Salim Al Harthy';


-- Count of appointments per department.
SELECT de.Department_Name, COUNT(a.Appointment_ID) AS Appointment_Count
FROM Appointment a
INNER JOIN Doctor d ON a.Doctor_ID = d.Doctor_ID
INNER JOIN Department de ON  d.Department_ID = de.Department_ID
GROUP BY de.Department_Name;

SELECT * FROM Department
SELECT * FROM Appointment
SELECT * FROM Doctor


-- Retrieve doctors who have more than 5 appointments in a month.
SELECT Doctor_Name,MONTH(a.Appointment_Date) AS Month,COUNT(*) AS Appointment_Count
FROM Appointment a
INNER JOIN Doctor d ON a.Doctor_ID = d.Doctor_ID
GROUP BY  d.Doctor_Name, MONTH(a.Appointment_Date)
HAVING COUNT(*) > 1; --> all doctors have 2 Appointment

-- There is no doctor have 5 appointment -- 
SELECT * FROM Appointment
SELECT * FROM Doctor

-- Use JOINs across 3–4 tables.
SELECT p.Patient_Name, d.Doctor_Name, a.Appointment_Date, a.Appointment_Time, m.Diagnosis
FROM Patient p
INNER JOIN Appointment a ON p.Patient_ID = a.Patient_ID
INNER JOIN Doctor d ON a.Doctor_ID = d.Doctor_ID
INNER JOIN MedicalRecord m ON a.Appointment_ID = m.Appointment_ID
WHERE p.Patient_Name = 'Fatma Al Balushi';

SELECT * FROM Appointment
SELECT * FROM Doctor
SELECT * FROM MedicalRecord
SELECT * FROM Patient


-- Use GROUP BY, HAVING, and aggregate functions.

SELECT d.Specialization, COUNT(*) AS Total_Doctors
FROM Doctor d
GROUP BY d.Specialization
HAVING COUNT(*) > 1;


SELECT * FROM Doctor

-- Use SUBQUERIES and EXISTS.


-- SUBQUERY to find patients with appointments in specific date
SELECT p.Patient_Name
FROM Patient p
WHERE p.Patient_ID IN (SELECT a.Patient_ID FROM Appointment a
WHERE a.Appointment_Date ='2025-06-16');

SELECT * FROM Patient
SELECT * FROM Appointment

-- EXISTS to check if a patient has any appointments
SELECT p.Patient_Name
FROM Patient p
WHERE EXISTS ( SELECT * FROM Appointment a WHERE a.Patient_ID = p.Patient_ID);

SELECT * FROM Patient
SELECT * FROM Appointment


