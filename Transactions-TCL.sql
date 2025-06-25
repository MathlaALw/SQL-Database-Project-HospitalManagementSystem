-- Transactions (TCL)

-- 1. Simulate a transaction: admit a patient → insert record, update room, create billing → commit.


BEGIN TRANSACTION;
INSERT INTO Admission (Date_In, Date_Out, Room_Number, Patient_ID, Staff_ID)
VALUES ('2025-06-21', '2025-06-25', 3, 3, 3);

UPDATE Rooms
SET Availability = 'False'
WHERE Room_Number = 3;

INSERT INTO Bill (Patient_ID, Total_Cost, P_Date, PaymentStatus)
VALUES (3, 200.00, GETDATE(), 'Unpaid');

COMMIT TRANSACTION;

SELECT * FROM Admission
SELECT * FROM Rooms
SELECT * FROM Bill

-- 2. Add rollback logic in case of failure.

BEGIN TRY
BEGIN TRANSACTION;

INSERT INTO Admission (Date_In, Date_Out, Room_Number, Patient_ID, Staff_ID)
VALUES ('2025-06-21', '2025-06-25', 3, 3, 3);

UPDATE Rooms
SET Availability = 'False'
WHERE Room_Number = 3;

INSERT INTO Bill (Patient_ID, Total_Cost, P_Date, PaymentStatus)
VALUES (3, 200.00, GETDATE(), 'Unpaid');

COMMIT TRANSACTION;
PRINT 'Transaction succeeded, committed.';
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION;
PRINT 'Transaction failed, rolled back.';
END CATCH;