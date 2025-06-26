-- Functions & Stored Procedures

-- 1. Scalar function to calculate patient age from DOB. 


CREATE FUNCTION dbo.CalculateAge(@DOB DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;
    SET @Age = DATEDIFF(YEAR, @DOB, GETDATE());
    RETURN @Age;
END;

SELECT dbo.CalculateAge('1990-01-01') AS Age;


-- 2. Stored procedure to admit a patient (insert to Admissions, update Room availability).

CREATE PROCEDURE AdmitPatient
@Patient_ID INT,
@Room_Number INT,
@Date_In DATE,
@Date_Out DATE,
@Staff_ID INT
AS
BEGIN
-- Insert into Admission table
INSERT INTO Admission (Date_In, Date_Out, Room_Number, Patient_ID, Staff_ID)
VALUES (@Date_In, @Date_Out, @Room_Number, @Patient_ID, @Staff_ID);
        
-- Update Room availability
UPDATE Rooms
SET Availability = 'False'
WHERE Room_Number = @Room_Number;
END;
   
   
-- calling the procedure
EXEC AdmitPatient @Patient_ID = 12, @Room_Number = 2, @Date_In = '2025-06-01', @Date_Out = '2025-06-05', @Staff_ID = 2;

SELECT * FROM Admission;
SELECT * FROM Rooms;


-- 3. Procedure to generate invoice (insert into Billing based on treatments).

CREATE PROCEDURE GenerateInvoice
@Patient_ID INT,
@Total_Cost DECIMAL(10, 2),
@PaymentStatus VARCHAR(50)
AS
BEGIN
-- Insert into Bill table
INSERT INTO Bill (Patient_ID, Total_Cost, P_Date, PaymentStatus)
VALUES (@Patient_ID, @Total_Cost, GETDATE(), @PaymentStatus);
END;
-- calling the procedure
EXEC GenerateInvoice @Patient_ID = 3, @Total_Cost = 200.00, @PaymentStatus = 'Paid';


SELECT * FROM Bill


-- 4. Procedure to assign doctor to department and shift.

CREATE PROCEDURE AssignDoctorToDepartment
@Doctor_ID INT,
@Department_ID INT,
@Shift VARCHAR(50),
@Shift_Date DATE
AS
BEGIN
-- Update Doctor table with Department and Shift
UPDATE Doctor
SET Department_ID = @Department_ID
WHERE Doctor_ID = @Doctor_ID;

-- Update Staff table with Shift and Shift_Date
UPDATE Staff
SET Shift = @Shift, Shift_Date = @Shift_Date
WHERE Staff_ID = (SELECT Staff_ID FROM Doctor WHERE Doctor_ID = @Doctor_ID);
END;


-- calling the procedure
EXEC AssignDoctorToDepartment @Doctor_ID = 1, @Department_ID = 1, @Shift = 'Morning', @Shift_Date = '2025-06-27';


SELECT * FROM Doctor
SELECT * FROM Staff

-----