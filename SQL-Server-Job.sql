-- SQL Server Job (SQL Agent Job)

-- Option 1 : Daily Backup Job
-- Test the Job Step Manually

BACKUP DATABASE HospitalManagmentDB
TO DISK = 'C:\SQLBackups\HospitalManagmentDB.bak'
WITH FORMAT, INIT, NAME = 'HospitalManagmentDB-Full Backup';


-- Option2 : Doctor Schedule Report


USE HospitalManagmentDB;


-- Create the DoctorDailyScheduleLog table

CREATE TABLE dbo.DoctorDailyScheduleLog (
    Log_ID INT IDENTITY(1,1) PRIMARY KEY,
    Doctor_ID INT NOT NULL,
    Appointment_ID INT NOT NULL,
    Appointment_Date DATE NOT NULL,
    Appointment_Time TIME NOT NULL,
    LoggedAt DATETIME DEFAULT GETDATE()
);


-- After creating the table, create the stored procedure 

ALTER PROCEDURE dbo.usp_GenerateDoctorScheduleLog
AS
BEGIN
    INSERT INTO dbo.DoctorDailyScheduleLog (Doctor_ID, Appointment_ID, Appointment_Date, Appointment_Time)
    SELECT 
        Doctor_ID,
        Appointment_ID,
        Appointment_Date,
        Appointment_Time
    FROM dbo.Appointment
    WHERE CAST(Appointment_Date AS DATE) = CAST(GETDATE() AS DATE);
END;

-- Test the procedure manually 

EXEC dbo.usp_GenerateDoctorScheduleLog;


-- Check if we have procedure with 'usp_GenerateDoctorScheduleLog' name 

SELECT name, SCHEMA_NAME(schema_id) AS schema_name, create_date
FROM sys.procedures
WHERE name = 'usp_GenerateDoctorScheduleLog';


SELECT * 
FROM sys.tables 
WHERE name = 'DoctorDailyScheduleLog';

-- To view the DoctorDailyScheduleLog table
SELECT * FROM DoctorDailyScheduleLog;

------------

-- Bonus Challenge (Optional)**

-- Set up a SQL job that:
-- - Sends an email alert if any doctor has more than 10 appointments per day.

-- 1. Enable Database Mail 

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;


-- - Create the Stored Procedure to Check Appointments and Send Email


USE HospitalManagmentDB;


CREATE OR ALTER PROCEDURE dbo.usp_AlertDoctorsOverloaded
AS
BEGIN
    DECLARE @AlertBody NVARCHAR(MAX) = '';
    DECLARE @DoctorList NVARCHAR(MAX) = '';

    -- Generate list of doctors with more than 10 appointments today
    SELECT @DoctorList = 
    COALESCE(@DoctorList + CHAR(13) + CHAR(10), '') +
    'Doctor ID: ' + CAST(Doctor_ID AS VARCHAR) + 
    ' | Appointments: ' + CAST(COUNT(*) AS VARCHAR)
    FROM Appointment
    WHERE CAST(Appointment_Date AS DATE) = '2025-06-10'
    GROUP BY Doctor_ID
    HAVING COUNT(*) > 1;

    -- Only send email if there are doctors found
    IF @DoctorList <> ''
    BEGIN
        SET @AlertBody = 
        'The following doctors have more than 10 appointments today:' + 
        CHAR(13) + CHAR(10) + @DoctorList;

        EXEC msdb.dbo.sp_send_dbmail
            @profile_name = 'HospitalMailProfile',
            @recipients = 'mathaalwahaibi67@gmail.com',
            @subject = 'Overloaded Doctors - Appointment Alert',
            @body = @AlertBody;
    END
END;


--  Schedule it via SQL Agent

EXEC dbo.usp_AlertDoctorsOverloaded;


EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'HospitalMailProfile',
    @recipients = 'mathlaalwahaibi67@gmail.com.com',
    @subject = 'Test Email from SQL Server',
    @body = 'This is a test email.';

	SELECT 
    mailitem_id,
    recipients,
    subject,
    sent_status,
    sent_date,
    last_mod_date,
    body
FROM msdb.dbo.sysmail_allitems
ORDER BY sent_date DESC;


SELECT * FROM msdb.dbo.sysmail_event_log ORDER BY log_date DESC;