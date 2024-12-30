-- Create the database
CREATE DATABASE IF NOT EXISTS HospitalManagement;
USE HospitalManagement;

-- Doctors table
CREATE TABLE IF NOT EXISTS doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    availability_schedule VARCHAR(255)
);

-- Patients table
CREATE TABLE IF NOT EXISTS patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age > 0 AND age < 120),
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

-- Appointments table
CREATE TABLE IF NOT EXISTS appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE
);

-- Medications table
CREATE TABLE IF NOT EXISTS medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50) NOT NULL
);

-- Prescriptions table
CREATE TABLE IF NOT EXISTS prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage_instructions TEXT NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id) ON DELETE CASCADE
);

-- Billing table
CREATE TABLE IF NOT EXISTS billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('Paid', 'Pending', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE
);

-- Sample data for testing
INSERT INTO doctors (name, specialization, phone_number, email, availability_schedule)
VALUES 
('Dr. John Doe', 'Cardiology', '1234567890', 'johndoe@example.com', 'Mon-Fri: 9am-5pm'),
('Dr. Jane Smith', 'Dermatology', '0987654321', 'janesmith@example.com', 'Tue-Thu: 10am-3pm');

INSERT INTO patients (name, age, gender, phone_number, email, address)
VALUES 
('Alice Johnson', 35, 'Female', '1112223333', 'alicej@example.com', '123 Main St'),
('Bob Brown', 42, 'Male', '4445556666', 'bobb@example.com', '456 Oak St');

INSERT INTO appointments (doctor_id, patient_id, appointment_date, appointment_time, status)
VALUES 
(1, 1, '2024-01-15', '10:30:00', 'Scheduled'),
(2, 2, '2024-01-16', '11:00:00', 'Completed');

INSERT INTO medications (name, dosage)
VALUES 
('Aspirin', '500mg'),
('Ibuprofen', '200mg');

INSERT INTO prescriptions (appointment_id, medication_id, dosage_instructions)
VALUES 
(1, 1, 'Take one tablet daily after meals'),
(2, 2, 'Take two tablets every 6 hours as needed');

INSERT INTO billing (appointment_id, amount, payment_status)
VALUES 
(1, 150.00, 'Pending'),
(2, 200.00, 'Paid');
