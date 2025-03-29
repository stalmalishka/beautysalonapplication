USE BeautySalonDB;

UPDATE Users SET status = 'DELETED' WHERE id = 1;
UPDATE Specializations SET status = 'DELETED' WHERE id = 1;
UPDATE Addresses SET status = 'DELETED' WHERE id = 1;
UPDATE Salons SET status = 'DELETED' WHERE id = 1;
UPDATE Employees SET status = 'DELETED' WHERE id = 1;
UPDATE Services SET status = 'DELETED' WHERE id = 1;
UPDATE Salons_Services SET status = 'DELETED' WHERE salon_id = 1 AND service_id = 1;
UPDATE Employees_Services SET status = 'DELETED' WHERE employee_id = 1 AND service_id = 1;
UPDATE Schedules SET status = 'DELETED' WHERE id = 1;
UPDATE Appointments SET status = 'DELETED' WHERE id = 1;
UPDATE Logins SET status = 'DELETED' WHERE id = 1;

-- hard delete
DELETE FROM Users WHERE status = 'DELETED';
DELETE FROM Specializations WHERE status = 'DELETED';
DELETE FROM Addresses WHERE status = 'DELETED';
DELETE FROM Salons WHERE status = 'DELETED';
DELETE FROM Employees WHERE status = 'DELETED';
DELETE FROM Services WHERE status = 'DELETED';
DELETE FROM Salons_Services WHERE status = 'DELETED';
DELETE FROM Employees_Services WHERE status = 'DELETED';
DELETE FROM Schedules WHERE status = 'DELETED';
DELETE FROM Appointments WHERE status = 'DELETED';
DELETE FROM Logins WHERE status = 'DELETED';

-- drop everything
DROP TABLE IF EXISTS Employees_Services;
DROP TABLE IF EXISTS Salons_Services;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Schedules;
DROP TABLE IF EXISTS Logins;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS Salons;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS Specializations;
DROP TABLE IF EXISTS Users;

