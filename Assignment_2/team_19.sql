CREATE DATABASE hospital_team_19;
\connect hospital_team_19

DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;


-- Create tables, set atributes and keys
CREATE TABLE DEPARTMENT (
    ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Building_number INT NOT NULL,
    Room_number INT NOT NULL
);

CREATE TABLE DOCTOR (
    ID SERIAL PRIMARY KEY,
    Full_name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    Hire_date DATE NOT NULL,
    Licence_number VARCHAR(50) UNIQUE NOT NULL,
    Department_ID INT NOT NULL,
    FOREIGN KEY (Department_ID)
        REFERENCES DEPARTMENT(ID)
        ON DELETE RESTRICT
);

CREATE TABLE PATIENT (
    ID SERIAL PRIMARY KEY,
    Full_name VARCHAR(100) NOT NULL,
    National_ID VARCHAR(20) UNIQUE NOT NULL,
    Gender TEXT,
    Date_of_birth DATE NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address TEXT
);

CREATE TABLE APPOINTMENT (
    ID SERIAL PRIMARY KEY,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Status TEXT,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    FOREIGN KEY (Patient_ID)
        REFERENCES PATIENT(ID)
        ON DELETE CASCADE,
    FOREIGN KEY (Doctor_ID)
        REFERENCES DOCTOR(ID)
        ON DELETE CASCADE
);

CREATE TABLE DIAGNOSIS (
    ID SERIAL PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Description TEXT,
    Appointment_ID INT UNIQUE NOT NULL,
    FOREIGN KEY (Appointment_ID)
        REFERENCES APPOINTMENT(ID)
        ON DELETE CASCADE
);

CREATE TABLE PROCEDURE (
    ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) CHECK (Price >= 0)
);

CREATE TABLE APPOINTMENT_PROCEDURE (
    ID SERIAL PRIMARY KEY,
    Appointment_ID INT NOT NULL,
    Procedure_ID INT NOT NULL,
    FOREIGN KEY (Appointment_ID)
        REFERENCES APPOINTMENT(ID)
        ON DELETE CASCADE,
    FOREIGN KEY (Procedure_ID)
        REFERENCES PROCEDURE(ID)
        ON DELETE CASCADE
);

-- Load data from CSV
\copy department FROM 'data/DEPARTMENT.csv' DELIMITER ',' CSV HEADER;
\copy doctor FROM 'data/DOCTOR.csv' DELIMITER ',' CSV HEADER;
\copy patient FROM 'data/PATIENT.csv' DELIMITER ',' CSV HEADER;
\copy procedure FROM 'data/PROCEDURE.csv' DELIMITER ',' CSV HEADER;
\copy appointment FROM 'data/APPOINTMENT.csv' DELIMITER ',' CSV HEADER;
\copy diagnosis FROM 'data/DIAGNOSIS.csv' DELIMITER ',' CSV HEADER;
\copy appointment_procedure FROM 'data/APPOINTMENT_PROCEDURE.csv' DELIMITER ',' CSV HEADER;