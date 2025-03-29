CREATE DATABASE BeautySalonDB;
USE BeautySalonDB;

CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    surname VARCHAR(40) NOT NULL,
    name VARCHAR(40) NOT NULL,
    email VARCHAR(40) UNIQUE NOT NULL,
    phone VARCHAR(15) CHECK (LENGTH(phone) >= 7),
    role ENUM('CLIENT', 'EMPLOYEE', 'ADMIN') NOT NULL DEFAULT 'CLIENT',
    status ENUM('ACTIVE', 'DELETED') NOT NULL DEFAULT 'ACTIVE',
    isSubscribed boolean DEFAULT false
);

CREATE TABLE Specializations (
                                 id INT AUTO_INCREMENT PRIMARY KEY,
                                 name VARCHAR(40) NOT NULL,
                                 status ENUM('ACTIVE', 'DELETED') NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE Addresses (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           city VARCHAR(40) NOT NULL,
                           street VARCHAR(40) NOT NULL,
                           house_number INT NOT NULL,
                           status ENUM('ACTIVE', 'DELETED') NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE Salons (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(40) NOT NULL,
                        address_id INT,
                        phone VARCHAR(15) CHECK (LENGTH(phone) >= 7),
                        instagram VARCHAR(40),
                        status ENUM('ACTIVE', 'DELETED') NOT NULL DEFAULT 'ACTIVE',
                        CONSTRAINT fk_salon_address FOREIGN KEY (address_id) REFERENCES Addresses(id)
                            ON DELETE SET NULL
                            ON UPDATE CASCADE
);

CREATE TABLE Employees (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           user_id INT UNIQUE NOT NULL,
                           services_id INT,
                           specialization_id INT,
                           salon_id INT,
                           instagram VARCHAR(40),
                           status ENUM('ACTIVE', 'DELETED') NOT NULL DEFAULT 'ACTIVE',
                           CONSTRAINT fk_employee_user FOREIGN KEY (user_id) REFERENCES Users(id)
                               ON DELETE CASCADE
                               ON UPDATE CASCADE,
                           CONSTRAINT fk_employee_specialization FOREIGN KEY (specialization_id) REFERENCES Specializations(id)
                               ON DELETE SET NULL
                               ON UPDATE CASCADE,
                           CONSTRAINT fk_employee_salon FOREIGN KEY (salon_id) REFERENCES Salons(id)
                               ON DELETE SET NULL
                               ON UPDATE CASCADE
);

CREATE TABLE Services (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          description TEXT,
                          price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
                          duration_minutes INT NOT NULL CHECK (duration_minutes > 0),
                          status ENUM('ACTIVE', 'DELETED') NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE Salons_Services (
                                 salon_id INT NOT NULL,
                                 service_id INT NOT NULL,
                                 PRIMARY KEY (salon_id, service_id),
                                 CONSTRAINT fk_salon_service_salon FOREIGN KEY (salon_id) REFERENCES Salons(id)
                                     ON DELETE CASCADE
                                     ON UPDATE CASCADE,
                                 CONSTRAINT fk_salon_service_service FOREIGN KEY (service_id) REFERENCES Services(id)
                                     ON DELETE CASCADE
                                     ON UPDATE CASCADE
);

CREATE TABLE Employees_Services (
                                    employee_id INT NOT NULL,
                                    service_id INT NOT NULL,
                                    PRIMARY KEY (employee_id, service_id),
                                    CONSTRAINT fk_employee_service_employee FOREIGN KEY (employee_id) REFERENCES Employees(id)
                                        ON DELETE CASCADE
                                        ON UPDATE CASCADE,
                                    CONSTRAINT fk_employee_service_service FOREIGN KEY (service_id) REFERENCES Services(id)
                                        ON DELETE CASCADE
                                        ON UPDATE CASCADE
);

CREATE TABLE Schedules (
	id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    work_date DATE NOT NULL,
    start_working_time TIME NOT NULL,
    end_working_time TIME NOT NULL,
    status ENUM('ACTIVE', 'DELETED') NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_schedule_employee FOREIGN KEY (employee_id) REFERENCES Employees(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

DELIMITER $$

CREATE TRIGGER before_insert_schedule
    BEFORE INSERT ON Schedules
    FOR EACH ROW
BEGIN
    IF NEW.work_date < CURRENT_DATE THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'work_date must be today or in the future';
    END IF;

    IF NEW.end_working_time <= NEW.start_working_time THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'end_working_time must be greater than start_working_time';
    END IF;
END $$

DELIMITER ;

CREATE TABLE Appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    employee_id INT NOT NULL,
    service_id INT NOT NULL,
    salon_id INT NOT NULL,
    appointment_date datetime NOT NULL,
    status ENUM('ACTIVE', 'DELETED') NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_appointment_client FOREIGN KEY (client_id) REFERENCES Users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_appointment_employee FOREIGN KEY (employee_id) REFERENCES Employees(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_appointment_service FOREIGN KEY (service_id) REFERENCES Services(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_appointment_salon FOREIGN KEY (salon_id) REFERENCES Salons(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

DELIMITER $$

CREATE TRIGGER before_insert_appointment
    BEFORE INSERT ON Appointments
    FOR EACH ROW
BEGIN
    IF NEW.appointment_date < NOW() THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'appointment_date must be in the future';
    END IF;
END $$

DELIMITER ;


CREATE TABLE Logins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    login VARCHAR(40) NOT NULL CHECK (LENGTH(login) >= 8),
    password VARCHAR(40) NOT NULL CHECK (LENGTH(password) >= 8),
    status ENUM('ACTIVE', 'DELETED') NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_login_user FOREIGN KEY (user_id) REFERENCES Users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);