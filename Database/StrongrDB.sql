--
-- DATABASE: StrongrDB
-- VERSION: 3.1
-- DATE: 09/06/2020
--

-- 
-- Tables
--

-- Muscle --
CREATE TABLE _muscle(
   id_muscle SERIAL,
   name VARCHAR(255) NOT NULL,
   PRIMARY KEY(id_muscle)
);

-- Equipment --
CREATE TABLE _equipment(
   id_equipment SERIAL,
   name VARCHAR(255) NOT NULL,
   description TEXT,
   image VARCHAR(255) UNIQUE,
   PRIMARY KEY(id_equipment)
);

-- User --
CREATE TABLE _user(
   id_user SERIAL,
   email VARCHAR(255) NOT NULL UNIQUE,
   password VARCHAR(255) NOT NULL,
   firstname VARCHAR(255) NOT NULL,
   lastname VARCHAR(255) NOT NULL,
   phonenumber VARCHAR(255),
   birthdate DATE NOT NULL,
   username VARCHAR(255) NOT NULL UNIQUE,
   weight REAL,
   signeddate TIMESTAMP NOT NULL,
   recoverycode VARCHAR(255),
   PRIMARY KEY(id_user)
);

-- AppExercise --
CREATE TABLE _app_exercise(
   id_app_exercise SERIAL,
   name VARCHAR(255) NOT NULL,
   description TEXT,
   image VARCHAR(255) UNIQUE,
   PRIMARY KEY(id_app_exercise)
);

-- SessionType --
CREATE TABLE _session_type(
   id_session_type SERIAL,
   name VARCHAR(255) NOT NULL,
   description TEXT,
   PRIMARY KEY(id_session_type)
);

-- ProgramGoal --
CREATE TABLE _program_goal(
   id_program_goal SERIAL,
   name VARCHAR(255) NOT NULL,
   description TEXT,
   PRIMARY KEY(id_program_goal)
);

-- Exercise --
CREATE TABLE _exercise(
   id_exercise SERIAL,
   id_app_exercise INT NOT NULL,
   id_user INT NOT NULL,
   id_equipment INT,
   name VARCHAR(255) NOT NULL,
   creation_date TIMESTAMP,
   last_update TIMESTAMP,
   PRIMARY KEY(id_app_exercise, id_user, id_exercise),
   FOREIGN KEY(id_app_exercise) REFERENCES _app_exercise(id_app_exercise),
   FOREIGN KEY(id_user) REFERENCES _user(id_user),
   FOREIGN KEY(id_equipment) REFERENCES _equipment(id_equipment)
);

-- Session --
CREATE TABLE _session(
   id_session SERIAL,
   id_user INT NOT NULL,
   id_session_type INT NOT NULL,
   name VARCHAR(255) NOT NULL,
   creation_date TIMESTAMP,
   last_update TIMESTAMP,
   PRIMARY KEY(id_user, id_session),
   FOREIGN KEY(id_user) REFERENCES _user(id_user),
   FOREIGN KEY(id_session_type) REFERENCES _session_type(id_session_type)
);

-- Program --
CREATE TABLE _program(
   id_program SERIAL,
   id_user INT NOT NULL,
   id_program_goal INT NOT NULL,
   name VARCHAR(255) NOT NULL,
   creation_date TIMESTAMP,
   last_update TIMESTAMP,
   PRIMARY KEY(id_user, id_program),
   FOREIGN KEY(id_user) REFERENCES _user(id_user),
   FOREIGN KEY(id_program_goal) REFERENCES _program_goal(id_program_goal)
);

-- Set --
CREATE TABLE _set(
   id_set SERIAL,
   id_user INT NOT NULL,
   id_exercise INT NOT NULL,
   id_app_exercise INT NOT NULL,
   place INT NOT NULL,
   repetitions_count INT,
   rest_time INT,
   expected_performance INT,
   realized_performance INT,
   PRIMARY KEY(id_app_exercise, id_user, id_exercise, id_set),
   FOREIGN KEY(id_app_exercise, id_user, id_exercise) REFERENCES _exercise(id_app_exercise, id_user, id_exercise)
);

-- 
-- Contrainte d’Intégrité Multiple (CIM)
--

-- Program <> Session --
CREATE TABLE _program_session(
   id_user INT,
   id_user_1 INT,
   id_program INT,
   id_session INT,
   place INT NOT NULL,
   PRIMARY KEY(id_user, id_user_1, id_program,  id_session),
   FOREIGN KEY(id_user, id_program) REFERENCES _program(id_user, id_program),
   FOREIGN KEY(id_user_1, id_session) REFERENCES _session(id_user, id_session)
);

-- Session <> Exercise --
CREATE TABLE _session_exercise(
   id_user INT,
   id_user_1 INT,
   id_session INT,
   id_exercise INT,
   id_app_exercise INT,
   place INT NOT NULL,
   PRIMARY KEY(id_user, id_user_1, id_session, id_exercise, id_app_exercise),
   FOREIGN KEY(id_app_exercise, id_user, id_exercise) REFERENCES _exercise(id_app_exercise, id_user, id_exercise),
   FOREIGN KEY(id_user_1, id_session) REFERENCES _session(id_user, id_session)
);

-- AppExercise <> Muscle --
CREATE TABLE _app_exercise_muscle(
   id_app_exercise INT,
   id_muscle INT,
   PRIMARY KEY(id_muscle, id_app_exercise),
   FOREIGN KEY(id_muscle) REFERENCES _muscle(id_muscle),
   FOREIGN KEY(id_app_exercise) REFERENCES _app_exercise(id_app_exercise)
);

-- AppExercise <> Equipment --
CREATE TABLE _app_exercise_equipment(
   id_app_exercise INT,
   id_equipment INT,
   PRIMARY KEY(id_equipment, id_app_exercise),
   FOREIGN KEY(id_equipment) REFERENCES _equipment(id_equipment),
   FOREIGN KEY(id_app_exercise) REFERENCES _app_exercise(id_app_exercise)
);
