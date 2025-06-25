use HospitalManagmentDB
-- Triggers

-- 1. After insert on Appointments → auto log in MedicalRecords.

CREATE TRIGGER trg_AfterInsertAppointment
ON Appointment
AFTER INSERT
AS
BEGIN
    INSERT INTO MedicalRecord (Patient_ID, Doctor_ID, Appointment_ID, Diagnosis, TreatmentPlans, Date, Time, Cost)
    SELECT 
        a.Patient_ID,
        a.Doctor_ID,
        a.Appointment_ID,
        'Initial Checkup',
        NULL,
        GETDATE(), 
        GETDATE(), 
        0.00 
    FROM inserted a;
END;


-- calling the trigger
INSERT INTO Appointment (Patient_ID, Doctor_ID, Appointment_Date, Appointment_Time)
VALUES (1, 1, '2025-06-21', '10:00');

SELECT * FROM Appointment

-- 2. Before delete on Patients → prevent deletion if pending bills exist.

CREATE TRIGGER trg_BeforeDeletePatient
ON Patient
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM Bill WHERE Patient_ID IN (SELECT Patient_ID FROM deleted) AND PaymentStatus = 'Unpaid')
    BEGIN
        RAISERROR('Cannot delete patient with pending bills.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM Patient WHERE Patient_ID IN (SELECT Patient_ID FROM deleted);
    END
END;

-- calling the trigger

DELETE FROM Patient WHERE Patient_ID = 3; -- Show 'Cannot delete patient with pending bills.'

SELECT * FROM Patient
SELECT * FROM Bill


-- 3. After update on Rooms → ensure no two patients occupy same room.


CREATE TRIGGER trg_AfterUpdateRoom
ON Rooms
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM Admission WHERE Room_Number IN (SELECT Room_Number FROM inserted) AND Date_Out IS NULL)
    BEGIN
        RAISERROR('Room is already occupied by another patient.', 16, 1);
        --ROLLBACK TRANSACTION; -- 
    END
END;

-- calling the trigger

UPDATE Rooms
SET Availability = 'False'
WHERE Room_Number = 3; -- Show 'Room is already occupied by another patient.'

SELECT * FROM Rooms
SELECT * FROM Admission
---
UPDATE Admission
SET Date_Out = NULL
WHERE Room_Number = 10;


----