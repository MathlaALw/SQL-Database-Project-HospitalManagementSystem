# SQL Database Project: Hospital Management System

## PDF Documentation 

[SQL Database Project : Hospital Management System](./PDF/SQL-Database-Project.pdf)

## ERD 

![ERD](./images/ErdHospitalManagementSystem.png)

## Mapping 

![Mapping](./images/Mapping-HospitalManagementSystem.png)


## Normalization

**UNF**
	
**Patient Table:**

|PatientID|PatientName|Gender|Address|PhoneNumber          |
|---------|-----------|------|-------|---------------------|
|1        |Salim      |Male  |Muscat |99887766 , 98989898  |
|2        |Aisha      |Female|Muscat |99887767             |
|3        |Omar       |Male  |Muscat |99887768, 99889988   |

**1st Normal Form (1NF):**

**Patient Table:**

|PatientID|PatientName|Gender|Address|
|---------|-----------|------|-------|
|1        |Salim      |Male  |Muscat |
|2        |Aisha      |Female|Muscat |
|3        |Omar       |Male  |Muscat |

**PatientPhone Table:**

|PatientID|PhoneNumber |
|---------|------------|
|1        |99887766    |
|1        |98989898    |
|2        |99887767    |
|3        |99887768    |
|3        |99889988    |


**2nd Normal Form (2NF):**
- The PatientPhone table is already in 2NF as it has a composite key (PatientID, PhoneNumber) and no partial dependencies.
**3rd Normal Form (3NF):**
- already in 3NF as there are no transitive dependencies.

---


**Doctor Table:**

|DoctorID |DoctorName |Specialization |PhoneNumber         |Email            |Address          |
|---------|-----------|---------------|---------------------|-----------------|---------------- |
|1        |Dr. Ahmed  |Cardiology     |99887766 , 98989898  |ahmed@gmail.com  |Muscat           |
|2        |Dr. Fatima |Neurology      |99887767             |fatima@gmail.com |Muscat           |
|3        |Dr. Ali    |Pediatrics     |99887768, 99889988   |ali@gmail.com    |Salalah          |


**1st Normal Form (1NF):**


**Doctor Table:**


|DoctorID |DoctorName |Specialization |Email            |Address          |
|---------|-----------|---------------|-----------------|-----------------|
|1        |Dr. Ahmed  |Cardiology     |ahmed@gmail.com  |Muscat           |
|2        |Dr. Fatima |Neurology      |fatima@gmail.com |Muscat           |
|3        |Dr. Ali    |Pediatrics     |ali@gmail.com    |Salalah          |

**DoctorPhone Table:**

|DoctorID |PhoneNumber |
|---------|------------|
|1        |99887766    |
|1        |98989898    |
|2        |99887767    |
|3        |99887768    |
|3        |99889988    |

---
**Appointment Table:**

|AppointmentID |PatientID |DoctorID |AppointmentDate |AppointmentTime |
|-------------|----------|---------|-----------------|-----------------|
|1            |1         |1        |2023-10-01      |10:00 AM         |
|2            |2         |2        |2023-10-02      |11:00 AM         |
|3            |3         |3        |2023-10-03      |12:00 PM         |


**MedicalRecord Table:**

|MR_ID |PatientID |DoctorID |AppointmentID |Diagnosis       |TreatmentPlans       |Date      |Time     |Cost |
|-------|----------|---------|---------------|-----------------|----------------------|----------|---------|-----|
|1      |1         |1        |1              |Flu              |Hydration       |2023-10-01|10:30 AM |50   |
|2      |2         |2        |2              |Migraine          |Medication   |2023-10-02|11:30 AM |75   |
|3      |3         |3        |3              |Fever             |Medication  |2023-10-03|12:30 PM |60   |

---

**Bill Table:**

|BillID   |PatientID |TotalAmount |PaymentStatus  |
|---------|----------|------------|---------------|
|1        |1         |50          |Paid           |
|2        |2         |75          |Unpaid         |
|3        |3         |60          |Paid           |

---

**Department Table:**

|DepartmentID |DepartmentName |
|---------|----------------|
|1        |Cardiology      |
|2        |Neurology       |
|3        |Pediatrics      |

---

**Staff Table:**

|StaffID  |StaffName|Role         |PhoneNumber           |Email            |Address          |
|---------|---------|-------------|----------------------|-----------------|-----------------|
|1        |Sara     |Admin        |98777777              |sara@gmail.com   | Muscat          |
|2        |Faisal   |Reception    |95115915,99663322     |faisal@gmail.com | Muscat          |

**1st Normal Form (1NF):**

**Staff Table:**

|StaffID  |StaffName|Role         |Email            |Address          |Shift  |Shift_Date |DepartmentID |	
|---------|---------|-------------|-----------------|-----------------|-------|-----------|--------------|
|1        |Sara     |Admin        |sara@gmail.com   | Muscat          |Night  |2023-10-01 |1            |
|2        |Faisal   |Reception    |faisal@gmail.com | Muscat          |Morning|2023-10-02 |2            |


**StaffPhone Table:**

|StaffID  |PhoneNumber |
|---------|------------|
|1        |98777777    |
|2        |95115915    |
|2        |99663322    |

---

**User Table:**

|UserID   |Username  |Password  |
|---------|----------|----------|
|1        |admin     |admin123  |
|2        |reception |reception123|

---

**Admission Table:**

|AdmissionID |DateIn |DateOut |RoomNumber |PatientID |StuffID |
|-------------|-------|--------|-----------|----------|--------|
|1            |2023-10-01|2023-10-05|101       |1         |1       |
|2            |2023-10-02|2023-10-06|102       |2         |2       |


---

**Room Table:**

|RoomNumber |RoomType    |Availability |
|-----------|------------|-------------|
|101        |ICU         |True    |
|102        |General     |False |
|103        |Private     |True    |



------


## SQL Script 

```sql
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



```
