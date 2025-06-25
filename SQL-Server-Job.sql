-- SQL Server Job (SQL Agent Job)


-- 1. Daily Backup Job 
-- - Job Name: Daily_HospitalDB_Backup 
-- - Schedule: Every day at 2:00 AM 
-- - Action: Database backup 


USE master;


-- 1. Create the Job
EXEC msdb.dbo.sp_add_job
    @job_name = N'Daily_HospitalManagmentDB_Backup';


-- 2. Add a Job Step to perform the backup
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Daily_HospitalManagmentDB_Backup',
    @step_name = N'Backup Database',
    @subsystem = N'TSQL',
    @command = N'BACKUP DATABASE HospitalManagmentDB TO DISK = ''C:\Backups\HospitalManagmentDB.bak'' WITH INIT;',
    @retry_attempts = 3,
    @retry_interval = 5;


-- 3. Create a Daily Schedule at 2:00 AM
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'Daily_2AM',
    @freq_type = 4,           -- Daily
    @freq_interval = 1,       -- Every day
    @active_start_time = 020000; -- 2:00 AM in HHMMSS


-- 4. Attach the schedule to the job
EXEC msdb.dbo.sp_attach_schedule
    @job_name = N'Daily_HospitalManagmentDB_Backup',
    @schedule_name = N'Daily_2AM';


-- 5. Assign the job to the local server
EXEC msdb.dbo.sp_add_jobserver
    @job_name = N'Daily_HospitalManagmentDB_Backup',
    @server_name = N'(local)';


