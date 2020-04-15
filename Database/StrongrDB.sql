CREATE TABLE _muscle(
   id_muscle SERIAL,
   name VARCHAR(255) NOT NULL,
   PRIMARY KEY(id_muscle)
);

CREATE TABLE _equipment(
   id_equipment SERIAL,
   name VARCHAR(255) NOT NULL,
   PRIMARY KEY(id_equipment)
);

CREATE TABLE _user(
   id_user SERIAL,
   email VARCHAR(255) NOT NULL UNIQUE,
   password VARCHAR(255) NOT NULL,
   firstname VARCHAR(255) NOT NULL,
   lastname VARCHAR(255) NOT NULL,
   phonenumber VARCHAR(255),
   birthdate DATE NOT NULL,
   username VARCHAR(255) NOT NULL UNIQUE,
   signeddate TIMESTAMP NOT NULL,
   recoverycode VARCHAR(255),
   PRIMARY KEY(id_user)
);

CREATE TABLE _program(
   id_program SERIAL,
   id_user INT,
   name VARCHAR(255) NOT NULL,
   PRIMARY KEY(id_user, id_program),
   FOREIGN KEY(id_user) REFERENCES _user(id_user)
);

CREATE TABLE _session(
   id_session SERIAL,
   id_user INT,
   name VARCHAR(255) NOT NULL,
   PRIMARY KEY(id_user, id_session),
   FOREIGN KEY(id_user) REFERENCES _user(id_user)
);

CREATE TABLE app_exercise(
   id_app_exercise SERIAL,
   name VARCHAR(255) NOT NULL,
   PRIMARY KEY(id_app_exercise),
   
);

CREATE TABLE exercise(
   id_exercise SERIAL,
   id_app_exercise INT,
   id_user INT,
   name VARCHAR(255) NOT NULL,
   id_equipment INT,
   PRIMARY KEY(id_app_exercise, id_user, id_exercise),
   FOREIGN KEY(id_app_exercise) REFERENCES app_exercise(id_app_exercise),
   FOREIGN KEY(id_user) REFERENCES user_(id_user),
   FOREIGN KEY(id_equipment) REFERENCES equipment(id_equipment)
);

CREATE TABLE _set(
   id_set SERIAL,
   id_app_exercise INT,
   id_user INT,
   id_exercise INT,
   repetitions_count INT,
   rest_time INT,
   expected_performance INT,
   realized_performance INT,
   PRIMARY KEY(id_app_exercise, id_user, id_exercise, id_set),
   FOREIGN KEY(id_app_exercise, id_user, id_exercise) REFERENCES _exercise(id_app_exercise, id_user, id_exercise)
);

CREATE TABLE _composes(
   id_user INT,
   id_program INT,
   id_user_1 INT,
   id_session INT,
   PRIMARY KEY(id_user, id_program, id_user_1, id_session),
   FOREIGN KEY(id_user, id_program) REFERENCES _program(id_user, id_program),
   FOREIGN KEY(id_user_1, id_session) REFERENCES _session(id_user, id_session)
);

CREATE TABLE _comprises(
   id_app_exercise INT,
   id_user INT,
   id_exercise INT,
   id_user_1 INT,
   id_session INT,
   PRIMARY KEY(id_app_exercise, id_user, id_exercise, id_user_1, id_session),
   FOREIGN KEY(id_app_exercise, id_user, id_exercise) REFERENCES _exercise(id_app_exercise, id_user, id_exercise),
   FOREIGN KEY(id_user_1, id_session) REFERENCES _session(id_user, id_session)
);

CREATE TABLE _targets(
   id_muscle INT,
   id_app_exercise INT,
   PRIMARY KEY(id_muscle, id_app_exercise),
   FOREIGN KEY(id_muscle) REFERENCES _muscle(id_muscle),
   FOREIGN KEY(id_app_exercise) REFERENCES _app_exercise(id_app_exercise)
);

CREATE TABLE _suggests(
   id_equipment INT,
   id_app_exercise INT,
   PRIMARY KEY(id_equipment, id_app_exercise),
   FOREIGN KEY(id_equipment) REFERENCES equipment(id_equipment),
   FOREIGN KEY(id_app_exercise) REFERENCES app_exercise(id_app_exercise)
);
