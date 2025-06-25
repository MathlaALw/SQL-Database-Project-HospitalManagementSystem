-- Create database 
create database HospitalManagmentDB;

-- use database
use HospitalManagmentDB;

------------

-- Patients Table
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY IDENTITY(1,1),
    Patient_Name VARCHAR(100) NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female')),
    Address VARCHAR(255) NOT NULL,
	Email VARCHAR(100) NOT NULL UNIQUE
);


---------------------
---------------------
-- Error in adding new columns with not null 
ALTER TABLE Patient
ADD DOB DATE NOT NULL 

-- Solve--
-- Step 1: Add the column allowing NULLs
ALTER TABLE Patient
ADD DOB DATE NULL;

-- Step 2: Update existing rows
UPDATE Patient
SET DOB = '1990-01-01';  -- or set values based on your logic

-- Step 3: Alter column to NOT NULL
ALTER TABLE Patient
ALTER COLUMN DOB DATE NOT NULL;


--------------------------------
--------------------------------
-- PatientPhone Table
CREATE TABLE PatientPhone (
    Patient_ID INT,
    Phone VARCHAR(15),
    PRIMARY KEY (Patient_ID, Phone),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Doctors Table
CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY IDENTITY(1,1),
    Doctor_Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Address VARCHAR(255) NOT NULL
);


ALTER TABLE Doctor
ADD Staff_ID INT NULL  FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)


SELECT * FROM Doctor

UPDATE Doctor
SET Staff_ID = 10

-- DoctorPhone Table
CREATE TABLE DoctorPhone (
    Doctor_ID INT,
    Phone VARCHAR(15),
    PRIMARY KEY (Doctor_ID, Phone),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Appointments Table
CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY IDENTITY(1,1),
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Appointment_Date DATE NOT NULL,
    Appointment_Time TIME NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Medical Records Table
CREATE TABLE MedicalRecord (
    MR_ID INT PRIMARY KEY IDENTITY(1,1),
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Appointment_ID INT NOT NULL,
    Diagnosis VARCHAR(255) NOT NULL,
    TreatmentPlans VARCHAR(255),
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Cost DECIMAL(10, 2) CHECK (Cost >= 0),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE NO ACTION ,
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID) ON DELETE NO ACTION
);

-- Bills Table
CREATE TABLE Bill (
    Bill_ID INT PRIMARY KEY IDENTITY(1,1),
    Patient_ID INT NOT NULL,
    Total_Cost DECIMAL(10, 2) CHECK (Total_Cost >= 0),
	P_Date DATE NOT NULL,
    PaymentStatus VARCHAR(50) DEFAULT 'Unpaid' CHECK (PaymentStatus IN ('Paid', 'Unpaid')),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Departments Table
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY IDENTITY(1,1),
    Department_Name VARCHAR(100) NOT NULL UNIQUE
);

-- ADDING  Department_ID AS FK IN Doctor Table
ALTER TABLE Doctor
ADD Department_ID INT NOT NULL FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)


-- Staff Table
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY IDENTITY(1,1),
    Staff_Name VARCHAR(100) NOT NULL,
    Role VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Address VARCHAR(255) NOT NULL,
    Shift VARCHAR(50) CHECK (Shift IN ('Morning', 'Evening', 'Night')),
    Shift_Date DATE,
    Department_ID INT NOT NULL,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);


CREATE TABLE StaffPhone (
    Staff_ID INT,
    Phone VARCHAR(15),
    PRIMARY KEY (Staff_ID, Phone),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);

-- Users
CREATE TABLE Users (
    User_ID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL
);

-- Rooms
CREATE TABLE Rooms (
    Room_Number INT PRIMARY KEY IDENTITY(1,1),
    Type VARCHAR(50) CHECK (Type IN ('ICU', 'General', 'Private')),
    Availability VARCHAR(10) DEFAULT 'True'
);

-- Admissions
CREATE TABLE Admission (
    Admission_ID INT PRIMARY KEY IDENTITY(1,1),
    Date_In DATE NOT NULL,
    Date_Out DATE,
    Room_Number INT NOT NULL,
    Patient_ID INT NOT NULL,
    Staff_ID INT NOT NULL,
    FOREIGN KEY (Room_Number) REFERENCES Rooms(Room_Number)ON DELETE NO ACTION ,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID) ON DELETE NO ACTION
);

-- DoctorPatient 

CREATE TABLE DoctorPatient (
    Doctor_ID INT NOT NULL,
    Patient_ID INT NOT NULL,
    PRIMARY KEY (Doctor_ID, Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-------------------------------------------------------

-- Adding Data into Tables 

-- Patient Table 

INSERT INTO Patient (Patient_Name, Gender, Address, Email) VALUES
('Ali Said', 'Male', 'Muscat', 'ali.said@gmail.com'),
('Fatma Al Balushi', 'Female', 'Sohar', 'fatma.balushi@gmail.com'),
('Mohammed Nasser', 'Male', 'Nizwa', 'm.nasser@gmail.com'),
('Salma Al Zadjali', 'Female', 'Ibri', 'salma.zadjali@gmail.com'),
('Hamed Al Amri', 'Male', 'Sur', 'hamed.amri@gmail.com'),
('Aisha Al Siyabi', 'Female', 'Barka', 'a.siyabi@gmail.com'),
('Saeed Al Farsi', 'Male', 'Rustaq', 'saeed.farsi@gmail.com'),
('Mona Al Busaidi', 'Female', 'Muscat', 'mona.busaidi@gmail.com'),
('Rashid Al Rawahi', 'Male', 'Suwaiq', 'rashid.rawahi@gmail.com'),
('Layla Al Hinai', 'Female', 'Salalah', 'layla.hinai@gmail.com'),
('Omar Al Abri', 'Male', 'Bahla', 'omar.abri@gmail.com'),
('Huda Al Mahrouqi', 'Female', 'Shinas', 'huda.mahrouqi@gmail.com'),
('Talib Al Habsi', 'Male', 'Izki', 'talib.habsi@gmail.com'),
('Rania Al Riyami', 'Female', 'Seeb', 'rania.riyami@gmail.com'),
('Majid Al Azri', 'Male', 'Bidbid', 'majid.azri@gmail.com'),
('Noura Al Lawati', 'Female', 'Amerat', 'noura.lawati@gmail.com'),
('Badr Al Nabhani', 'Male', 'Khasab', 'badr.nabhani@gmail.com'),
('Dina Al Shukaili', 'Female', 'Adam', 'dina.shukaili@gmail.com'),
('Khalid Al Maamari', 'Male', 'Al Suwaiq', 'khalid.maamari@gmail.com'),
('Shaima Al Maskari', 'Female', 'Mutrah', 'shaima.maskari@gmail.com');


-- PatientPhone Table

INSERT INTO PatientPhone (Patient_ID, Phone) VALUES
(1, '96890123401'),
(2, '96890123402'),
(3, '96890123403'),
(4, '96890123404'),
(5, '96890123405'),
(6, '96890123406'),
(7, '96890123407'),
(8, '96890123408'),
(9, '96890123409'),
(10, '96890123410'),
(11, '96890123411'),
(12, '96890123412'),
(13, '96890123413'),
(14, '96890123414'),
(15, '96890123415'),
(16, '96890123416'),
(17, '96890123417'),
(18, '96890123418'),
(19, '96890123419'),
(20, '96890123420');


Select * FROM Patient
SELECT * FROM PatientPhone

-- Department Table 
INSERT INTO Department (Department_Name) VALUES
('Cardiology'),
('Neurology'),
('Pediatrics'),
('Orthopedics'),
('Oncology'),
('Radiology'),
('Emergency'),
('Pathology'),
('Anesthesiology'),
('Dermatology'),
('Gastroenterology'),
('Endocrinology'),
('Psychiatry'),
('Urology'),
('Nephrology'),
('Ophthalmology'),
('ENT'),
('General Surgery'),
('Obstetrics and Gynecology'),
('Physical Therapy');

SELECT * FROM Department


-- Doctor table

INSERT INTO Doctor (Doctor_Name, Specialization, Email, Address, Department_ID) VALUES
('Dr. Salim Al Harthy', 'Cardiology', 'salim.harthy@hospital.com', 'Muscat', 1),
('Dr. Aisha Al Busaidi', 'Neurology', 'aisha.busaidi@hospital.com', 'Sohar', 2),
('Dr. Faisal Al Habsi', 'Pediatrics', 'faisal.habsi@hospital.com', 'Nizwa', 3),
('Dr. Mona Al Riyami', 'Orthopedics', 'mona.riyami@hospital.com', 'Ibri', 4),
('Dr. Ahmed Al Farsi', 'Oncology', 'ahmed.farsi@hospital.com', 'Sur', 5),
('Dr. Huda Al Azri', 'Cardiology', 'huda.azri@hospital.com', 'Muscat', 1),
('Dr. Khalfan Al Maamari', 'Neurology', 'khalfan.maamari@hospital.com', 'Suwaiq', 2),
('Dr. Samira Al Siyabi', 'Pediatrics', 'samira.siyabi@hospital.com', 'Salalah', 3),
('Dr. Majid Al Amri', 'Orthopedics', 'majid.amri@hospital.com', 'Rustaq', 4),
('Dr. Laila Al Hinai', 'Oncology', 'laila.hinai@hospital.com', 'Seeb', 5);

-- DoctorPhone Table 

INSERT INTO DoctorPhone (Doctor_ID, Phone) VALUES
(1, '96891234501'),
(2, '96891234502'),
(3, '96891234503'),
(4, '96891234504'),
(5, '96891234505'),
(6, '96891234506'),
(7, '96891234507'),
(8, '96891234508'),
(9, '96891234509'),
(10, '96891234510');

SELECT * FROM Doctor
SELECT * FROM DoctorPhone
-- DoctorPatient Table

INSERT INTO DoctorPatient (Doctor_ID, Patient_ID) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(1, 11),
(2, 12),
(3, 13),
(4, 14),
(5, 15),
(1, 16),
(2, 17),
(3, 18),
(4, 19),
(5, 20);

SELECT * FROM DoctorPatient

-- Staff Table

INSERT INTO Staff (Staff_Name, Role, Email, Address, Shift, Shift_Date, Department_ID) VALUES
('Huda Al Kindi', 'Nurse', 'huda.kindi@hospital.com', 'Ibri', 'Morning', '2025-06-24', 1),
('Yousef Al Rawahi', 'Receptionist', 'yousef.rawahi@hospital.com', 'Salalah', 'Evening', '2025-06-24', 2),
('Mariam Al Busaidi', 'Admin', 'mariam.busaidi@hospital.com', 'Muscat', 'Night', '2025-06-25', 3),
('Fahad Al Mahrouqi', 'Nurse', 'fahad.mahrouqi@hospital.com', 'Nizwa', 'Morning', '2025-06-25', 4),
('Latifa Al Shukaili', 'Receptionist', 'latifa.shukaili@hospital.com', 'Suwaiq', 'Evening', '2025-06-25', 5),
('Omar Al Amri', 'Nurse', 'omar.amri@hospital.com', 'Amerat', 'Night', '2025-06-26', 1),
('Samira Al Rawahi', 'Admin', 'samira.rawahi@hospital.com', 'Sohar', 'Morning', '2025-06-26', 2),
('Majid Al Lawati', 'Receptionist', 'majid.lawati@hospital.com', 'Muscat', 'Evening', '2025-06-26', 3),
('Rania Al Kharusi', 'Nurse', 'rania.kharusi@hospital.com', 'Sur', 'Night', '2025-06-27', 4),
('Salim Al Hinai', 'Admin', 'salim.hinai@hospital.com', 'Khasab', 'Morning', '2025-06-27', 5);

-- StaffPhone Table 
INSERT INTO StaffPhone (Staff_ID, Phone) VALUES
(1, '96892345601'),
(2, '96892345602'),
(3, '96892345603'),
(4, '96892345604'),
(5, '96892345605'),
(6, '96892345606'),
(7, '96892345607'),
(8, '96892345608'),
(9, '96892345609'),
(10, '96892345610');

SELECT * FROM Staff
SELECT * FROM StaffPhone

-- Appointment Table

INSERT INTO Appointment (Patient_ID, Doctor_ID, Appointment_Date, Appointment_Time) VALUES
(1, 1, '2025-06-01', '09:00'),
(2, 2, '2025-06-02', '10:30'),
(3, 3, '2025-06-03', '11:00'),
(4, 4, '2025-06-04', '08:30'),
(5, 5, '2025-06-05', '09:15'),
(6, 6, '2025-06-06', '10:45'),
(7, 7, '2025-06-07', '09:30'),
(8, 8, '2025-06-08', '11:15'),
(9, 9, '2025-06-09', '08:00'),
(10, 10, '2025-06-10', '10:00'),
(11, 1, '2025-06-11', '09:00'),
(12, 2, '2025-06-12', '10:30'),
(13, 3, '2025-06-13', '11:00'),
(14, 4, '2025-06-14', '08:30'),
(15, 5, '2025-06-15', '09:15'),
(16, 6, '2025-06-16', '10:45'),
(17, 7, '2025-06-17', '09:30'),
(18, 8, '2025-06-18', '11:15'),
(19, 9, '2025-06-19', '08:00'),
(20, 10, '2025-06-20', '10:00');

SELECT * FROM Appointment

-- MedicalRecord Table


INSERT INTO MedicalRecord (Patient_ID, Doctor_ID, Appointment_ID, Diagnosis, TreatmentPlans, Date, Time, Cost) VALUES
(1, 1, 1, 'Flu', 'hydration', '2025-06-01', '09:00', 20.00),
(2, 2, 2, 'Migraine', 'Painkillers', '2025-06-02', '10:30', 30.00),
(3, 3, 3, 'Fever', 'Paracetamol', '2025-06-03', '11:00', 25.00),
(4, 4, 4, 'Sprain', 'Physiotherapy', '2025-06-04', '08:30', 40.00),
(5, 5, 5, 'Cancer Screening', 'Lab tests', '2025-06-05', '09:15', 120.00),
(6, 6, 6, 'Heart Pain', 'ECG', '2025-06-06', '10:45', 150.00),
(7, 7, 7, 'Cough', 'Syrup', '2025-06-07', '09:30', 15.00),
(8, 8, 8, 'Back Pain', 'X-Ray', '2025-06-08', '11:15', 70.00),
(9, 9, 9, 'Fatigue', 'Blood Test', '2025-06-09', '08:00', 90.00),
(10, 10, 10, 'Headache', 'Painkillers', '2025-06-10', '10:00', 30.00),
(11, 1, 11, 'Fever', 'Panadol', '2025-06-11', '09:00', 25.00),
(12, 2, 12, 'Stress', 'Rest', '2025-06-12', '10:30', 45.00),
(13, 3, 13, 'Ear Infection', 'Antibiotics', '2025-06-13', '11:00', 40.00),
(14, 4, 14, 'Fracture', 'Casting', '2025-06-14', '08:30', 110.00),
(15, 5, 15, 'Cancer', 'Chemo Session', '2025-06-15', '09:15', 300.00),
(16, 6, 16, 'Arrhythmia', 'Monitoring', '2025-06-16', '10:45', 180.00),
(17, 7, 17, 'Diarrhea', 'Fluids', '2025-06-17', '09:30', 20.00),
(18, 8, 18, 'Injury', 'Wound Dressing', '2025-06-18', '11:15', 50.00),
(19, 9, 19, 'Fatigue', 'Tests', '2025-06-19', '08:00', 90.00),
(20, 10, 20, 'Anxiety', 'Counseling', '2025-06-20', '10:00', 60.00);

SELECT * FROM MedicalRecord

-- Bill Table 

INSERT INTO Bill (Patient_ID, Total_Cost, P_Date, PaymentStatus) VALUES
(1, 20.00, '2025-06-01', 'Paid'),
(2, 30.00, '2025-06-02', 'Paid'),
(3, 25.00, '2025-06-03', 'Unpaid'),
(4, 40.00, '2025-06-04', 'Paid'),
(5, 120.00, '2025-06-05', 'Unpaid'),
(6, 150.00, '2025-06-06', 'Paid'),
(7, 15.00, '2025-06-07', 'Paid'),
(8, 70.00, '2025-06-08', 'Unpaid'),
(9, 90.00, '2025-06-09', 'Paid'),
(10, 30.00, '2025-06-10', 'Paid'),
(11, 25.00, '2025-06-11', 'Paid'),
(12, 45.00, '2025-06-12', 'Unpaid'),
(13, 40.00, '2025-06-13', 'Paid'),
(14, 110.00, '2025-06-14', 'Paid'),
(15, 300.00, '2025-06-15', 'Unpaid'),
(16, 180.00, '2025-06-16', 'Paid'),
(17, 20.00, '2025-06-17', 'Paid'),
(18, 50.00, '2025-06-18', 'Unpaid'),
(19, 90.00, '2025-06-19', 'Paid'),
(20, 60.00, '2025-06-20', 'Paid');

SELECT * FROM Bill


-- Rooms Table 

INSERT INTO Rooms (Type, Availability) VALUES
('ICU', 'True'),
('General', 'True'),
('Private', 'True'),
('ICU', 'False'),
('General', 'True'),
('Private', 'False'),
('ICU', 'True'),
('General', 'False'),
('Private', 'True'),
('ICU', 'True');

SELECT * FROM Rooms

-- Admission Table


INSERT INTO Admission (Date_In, Date_Out, Room_Number, Patient_ID, Staff_ID) VALUES
('2025-06-01', '2025-06-05', 1, 1, 1),
('2025-06-02', '2025-06-06', 2, 2, 2),
('2025-06-03', '2025-06-07', 3, 3, 3),
('2025-06-04', '2025-06-08', 4, 4, 4),
('2025-06-05', '2025-06-09', 5, 5, 5),
('2025-06-06', '2025-06-10', 6, 6, 6),
('2025-06-07', '2025-06-11', 7, 7, 7),
('2025-06-08', '2025-06-12', 8, 8, 8),
('2025-06-09', '2025-06-13', 9, 9, 9),
('2025-06-10', '2025-06-14', 10, 10, 10),
('2025-06-11', '2025-06-15', 1, 11, 1),
('2025-06-12', '2025-06-16', 2, 12, 2),
('2025-06-13', '2025-06-17', 3, 13, 3),
('2025-06-14', '2025-06-18', 4, 14, 4),
('2025-06-15', '2025-06-19', 5, 15, 5),
('2025-06-16', '2025-06-20', 6, 16, 6),
('2025-06-17', '2025-06-21', 7, 17, 7),
('2025-06-18', '2025-06-22', 8, 18, 8),
('2025-06-19', '2025-06-23', 9, 19, 9),
('2025-06-20', '2025-06-24', 10, 20, 10);

SELECT * FROM Admission

-- Users Table

INSERT INTO Users (Username, Password) VALUES
('admin1', 'Pass@123'),
('admin2', 'Pass@456'),
('admin3', 'Pass@789'),
('user1', 'User@123'),
('user2', 'User@456'),
('user3', 'User@789'),
('nurse1', 'Nurse@123'),
('nurse2', 'Nurse@456'),
('doctor1', 'Doc@123'),
('reception', 'Recep@123');


SELECT * FROM Users

