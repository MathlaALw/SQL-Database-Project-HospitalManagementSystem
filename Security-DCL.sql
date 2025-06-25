-- Security (DCL)

-- 1. Create at least two user roles: DoctorUser, AdminUser.


CREATE ROLE DoctorUser;
CREATE ROLE AdminUser;


-- 2. GRANT SELECT for DoctorUser on Patients and Appointments only.

GRANT SELECT ON Patient TO DoctorUser;
GRANT SELECT ON Appointment TO DoctorUser;


-- 3. GRANT INSERT, UPDATE for AdminUser on all tables.

GRANT INSERT, UPDATE ON Patient TO AdminUser;
GRANT INSERT, UPDATE ON Appointment TO AdminUser;
GRANT INSERT, UPDATE ON Doctor TO AdminUser;
GRANT INSERT, UPDATE ON MedicalRecord TO AdminUser;
GRANT INSERT, UPDATE ON Bill TO AdminUser;
GRANT INSERT, UPDATE ON Department TO AdminUser;
GRANT INSERT, UPDATE ON Staff TO AdminUser;
GRANT INSERT, UPDATE ON Rooms TO AdminUser;
GRANT INSERT, UPDATE ON Admission TO AdminUser;
GRANT INSERT, UPDATE ON Users TO AdminUser;
GRANT INSERT, UPDATE ON DoctorPatient TO AdminUser;

-- 4. REVOKE DELETE for Doctors.

-- Grant permission
GRANT DELETE ON Patient TO DoctorUser;

-- Revoke permission
REVOKE DELETE ON Patient FROM DoctorUser;

