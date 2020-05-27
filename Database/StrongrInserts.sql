-- INSERT INTO public._user (id_user, email, password, firstname, lastname, phonenumber, birthdate, username, weight, signeddate, recoverycode)
-- VALUES
-- (
-- 	1, 
-- 	'strongr@test.org', 
-- 	'test', 
-- 	'Joe', 
-- 	'Laporte', 
-- 	'01 37 86 70 61 12', 
-- 	'1970-01-01 00:00:00', 
-- 	'Username', 
-- 	75, 
-- 	NOW(), 
-- 	'azerty'
-- );

INSERT INTO public._muscle(name)
VALUES
	('Abdominaux'),
	('Avant-bras'),
	('Biceps'),
	('Dos'),
	('Épaules'),
	('Ischios'),
	('Mollets'),
	('Pectoraux'),
	('Quadriceps'),
	('Triceps');

INSERT INTO public._app_exercise(name)
VALUES 
	('Crunch'),
	('Crunch à la poulie'),
	('Curls à la barre'),
	('Curls haltères'),
	('Curls poulie'),
	('Développés à la barre'),
	('Développés couché'),
	('Développés décliné'),
	('Développés épaules'),
	('Développés incliné'),
	('Dips'),
	('Dips entre deux bancs'),
	('Écartés haltères'),
	('Écartés poulies'),
	('Élévation à 45°'),
	('Élévation buste penché'),
	('Élévation frontale'),
	('Élévation latérale'),
	('Élévations frontales incliné'),
	('Extension à la poulie'),
	('Extension assis'),
	('Extension couché'),
	('Extension lombaire'),
	('Fentes'),
	('Flexion aux haltères'),
	('Flexion barre pronation'),
	('Flexion barre supination'),
	('Flexions latérales'),
	('Gainage'),
	('Good morning'),
	('Hack squat'),
	('Kickback'),
	('Leg curl assis'),
	('Leg curl debout'),
	('Leg extension'),
	('Mollets à la presse'),
	('Mollets assis'),
	('Mollets debout'),
	('Montée sur banc'),
	('Oiseau à la poulie'),
	('Pec-deck'),
	('Pompe'),
	('Presse à cuisse'),
	('Pullover'),
	('Relevés de jambes'),
	('Rotation avec bâton'),
	('Rowing'),
	('Rowing assis'),
	('Rowing barre T'),
	('Rowing deux haltères'),
	('Rowing haltère'),
	('Shrug'),
	('Shrug incliné haltères'),
	('Sissy squat'),
	('Soulevé de terre'),
	('Soulevé de terre jambes tendues'),
	('Squat'),
	('Squat barre guidée'),
	('Tirage horizontal'),
	('Tirage horizontal haut'),
	('Tirage menton'),
	('Tirage verticaux'),
	('Traction');

INSERT INTO public._app_exercise_muscle(id_app_exercise, id_muscle)
VALUES
	(1,	1),
	(2,	1),
	(3,	3),
	(4,	3),
	(5,	3),
	(6,	10),
	(7,	8),
	(8, 8),
	(9, 5),
	(10, 8),
	(11, 10),
	(12, 10),
	(13, 8),
	(14, 8),
	(15, 7),
	(16, 5),
	(17, 5),
	(18, 5),
	(19, 5),
	(20, 10),
	(21, 10),
	(22, 10),
	(23, 4),
	(24, 6),
	(25, 2),
	(26, 2),
	(27, 2),
	(28, 1),
	(29, 1),
	(30, 6),
	(31, 9),
	(32, 10),
	(33, 6),
	(34, 6),
	(35, 9),
	(36, 7),
	(37, 7),
	(38, 7),
	(39, 9),
	(40, 5),
	(41, 8),
	(42, 8),
	(43, 9),
	(44, 4),
	(45, 1),
	(46, 1),
	(47, 4),
	(48, 4),
	(49, 4),
	(50, 4),
	(51, 4),
	(52, 4),
	(53, 4),
	(54, 9),
	(55, 4),
	(56, 6),
	(57, 9),
	(58, 9),
	(59, 4),
	(60, 4),
	(61, 5),
	(62, 4),
	(63, 4);

INSERT INTO public._session_type(name, description)
VALUES 
	('Split body', 'Le split body met la priorité sur l''intensité du training et non sur la fréquence d''entrainement, il s''agit d''entraîner chaque muscle une unique fois par semaine, on va donc pouvoir aller à l''échec et utiliser des techniques d''intensification. Il faut cependant un bon niveau pour employer ces méthodes d''intensification de manière efficace.

	En compensant la réduction de la fréquence d''entrainement par l''intensité on peut s''assurer des gains aussi élevés qu''avec les autres méthodes.
	Les personnes ayant une mauvaise récupération doivent donc éviter le full body et préférer le split body, cependant si vous n''aimez pas le split ou n''arrivez pas à mettre beaucoup d''intensité en une séance il vaut mieux opter pour du half body ou du fullbody.'),
	('Half body', 'Le half body consiste quant à lui à entraîner le haut et le bas du corps séparément, en général 2 fois chacun par semaine. On va donc pouvoir mettre plus d''intensité qu''en full body, car les différentes parties du corps auront un peu plus de temps pour récupérer.

	Les personnes ayant une mauvaise récupération peuvent entraîner chaque moitié du corps tous les 5 jours, ce qui leurs permet de garder une bonne intensité tout en favorisant leur récupération.'),
	('Full body', 'Le full body est conseillé aux débutants en musculation car la répétition fréquente des exercices leur permet une adaptation nerveuse ainsi qu''un apprentissage des mouvements plus rapide. Il n''est cependant pas réservé qu''aux débutants, car ils ne peuvent pas mettre beaucoup d''intensité dans leurs séances, ce qui leur permet de travailler chaque muscle souvent.');


INSERT INTO _equipment (name) 
VALUES 
	('Banc'),
	('Presse horizontale'),
	('V Squat'),
	('Barre EZ'),
	('Machine guidée, tirage vertical'),
	('Machine guidée, tirage horizontal'),
	('Machine guidée, presse épaule'),
	('Barre de traction');

INSERT INTO public._exercise(id_app_exercise, id_user, name, id_equipment, creation_date, last_update)
VALUES 
	(1, 1, 'Exercice 1', 1, NOW(), NOW()),
	(1, 1, 'Exercice 2', 2, NOW() , NOW()),
	(1, 1, 'Exercice 3', 3, NOW() , NOW()),
	(1, 1, 'Exercice 4', null, NOW() , NOW()),
	(1, 1, 'Exercice 5', null, NOW() , NOW()),
	(1, 1, 'Exercice 6', null, NOW() , NOW());

INSERT INTO _session (id_user, id_session_type, name, creation_date, last_update)
VALUES 
	(1, 1, 'Séance 1', NOW(), NOW()),
	(1, 3, 'Séance 2', NOW(), NOW()),
	(1, 2, 'Séance 3', NOW(), NOW()),
	(1, null, 'Séance 4', NOW(), NOW()),
	(1, null, 'Séance 5', NOW(), NOW()),
	(1, null, 'Séance 6', NOW(), NOW());

INSERT INTO _session_exercise (id_app_exercise, id_user, id_exercise, id_user_1, id_session)
VALUES
	(1, 1, 1, 1, 1),
	(1, 1, 2, 1, 1),
	(1, 1, 3, 1, 1),
	(1, 1, 4, 1, 1),
	(1, 1, 5, 1, 1),
	(1, 1, 6, 1, 2);


INSERT INTO _program_goal (name, description)
VALUES 
	('Program goal 1', 'Description goal 1'),
	('Program goal 2', 'Description goal 2'),
	('Program goal 3', 'Description goal 3'),
	('Program goal 4', 'Description goal 4'),
	('Program goal 5', 'Description goal 5');


INSERT INTO _program (id_user, id_program_goal, name, creation_date, last_update)
VALUES 
	(1, 1, 'Programme 1', NOW(), NOW()),
	(1, 1, 'Programme 2', NOW(), NOW()),
	(1, 2, 'Programme 3', NOW(), NOW()),
	(1, 3, 'Programme 4', NOW(), NOW()),
	(1, 1, 'Programme 5', NOW(), NOW()),
	(1, 4, 'Programme 6', NOW(), NOW());


INSERT INTO _program_session (id_user, id_program, id_user_1, id_session)
VALUES
	(1, 1, 1, 1),
	(1, 2, 1, 1),
	(1, 3, 1, 1),
	(1, 1, 1, 3),
	(1, 2, 1, 2),
	(1, 4, 1, 2);
