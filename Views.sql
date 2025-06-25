-- Views 

-- 1. vw_DoctorSchedule: Upcoming appointments per doctor.

CREATE VIEW vw_DoctorSchedule AS
SELECT d.Doctor_Name, a.Appointment_Date, a.Appointment_Time
FROM Doctor d
INNER JOIN Appointment a ON d.Doctor_ID = a.Doctor_ID
WHERE a.Appointment_Date >= '2025-06-10'; --Shows all Appointment after this date 2025-06-10

-- calling the view
SELECT * FROM vw_DoctorSchedule;


SELECT * FROM Appointment
SELECT * FROM MedicalRecord


-- 2.  vw_PatientSummary: Patient info with their latest visit.

CREATE VIEW vw_PatientSummary AS
SELECT p.Patient_ID,p.Patient_Name,p.Gender,p.Address,MAX(a.Appointment_Date) AS Latest_Visit 
FROM Patient p
LEFT JOIN Appointment a ON p.Patient_ID = a.Patient_ID
GROUP BY p.Patient_ID, p.Patient_Name, p.Gender, p.Address;

-- calling the view
SELECT * FROM vw_PatientSummary;


-- 3. vw_DepartmentStats: Number of doctors and patients per department.

CREATE VIEW vw_DepartmentStats AS   
SELECT d.Department_Name AS 'Department Name', COUNT(DISTINCT doc.Doctor_ID) AS 'Total Doctors',COUNT(DISTINCT pat.Patient_ID) AS 'Total Patients'
FROM Department d
LEFT JOIN Doctor doc ON d.Department_ID = doc.Department_ID
LEFT JOIN DoctorPatient dp ON doc.Doctor_ID = dp.Doctor_ID
LEFT JOIN Patient pat ON dp.Patient_ID = pat.Patient_ID
GROUP BY d.Department_Name;

-- calling the view
SELECT * FROM vw_DepartmentStats;


