USE BeautySalonDB;

INSERT INTO Users (surname, name, email, phone, role) VALUES 
('Иванов', 'Иван', 'ivanov@i.com', '+375297773467', 'client'),
('Петрова', 'Мария', 'petrova@maha.com', '+375338952309', 'employee'),
('Смирнов', 'Алексей', 'smirnov@alex.com', '+375443378900', 'admin');

INSERT INTO Specializations (name) VALUES 
('Парикмахер'),
('Косметолог'),
('Массажист');

INSERT INTO Addresses (city, street, house_number) VALUES 
('Минск', 'Октябрьская', 15),
('Гродно', 'Белые Росы', 80),
('Витебск', 'Генерала Ивановского', 30);

INSERT INTO Salons (name, address_id, phone, instagram) VALUES 
('Гламур', 1, '+375293004040', 'glamour_salon'),
('Красотка', 2, '+375298080777', 'krasotka_salon'),
('Элегант', 3, '+3756667788', 'elegant_salon');

INSERT INTO Employees (user_id, specialization_id, salon_id, instagram) VALUES 
(2, 1, 1, 'mahaGlamur_insta');

INSERT INTO Services (name, description, price, duration_minutes) VALUES 
('Стрижка', 'Услуги стрижки волос', 150.00, 60),
('Укладка', 'Создание укладок любой сложности', 400.00, 150),
('Массаж', 'Общий массаж тела', 120.00, 120);

INSERT INTO Salons_Services (salon_id, service_id) VALUES 
(1, 1),
(1, 2),
(2, 3);

INSERT INTO Employees_Services (employee_id, service_id) VALUES 
(1, 1),
(1, 2);

INSERT INTO Schedules (employee_id, work_date, start_working_time, end_working_time) VALUES 
(1, '2024-11-20', '09:00:00', '18:00:00');

INSERT INTO Appointments (client_id, employee_id, service_id, salon_id, appointment_date) VALUES
(1, 1, 1, 1, '2024-11-20 10:00:00'),
(1, 1, 2, 1, '2024-11-21 11:00:00');

INSERT INTO Logins (user_id, login, password) VALUES 
(3, 'login', 'password');