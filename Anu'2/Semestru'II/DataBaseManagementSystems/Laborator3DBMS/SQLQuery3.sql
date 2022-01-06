USE [Cars]

CREATE TABLE Producer(
	ProducerID int PRIMARY KEY IDENTITY(1, 1),
	Name varchar(30),
	Country varchar(30)
);

CREATE TABLE Model(
	ModelID int PRIMARY KEY IDENTITY(1, 1),
	Name varchar(30),
	ProducerID int FOREIGN KEY REFERENCES Producer(ProducerID)
);

INSERT INTO Producer values('Dacia', 'Romania');
INSERT INTO Producer values('Mercedes', 'Germania');
INSERT INTO Producer values('BMW', 'Germania');
INSERT INTO Producer values('Peugeout', 'Franta');
INSERT INTO Producer values('Volkswagen', 'Germania');

INSERT INTO Model values('Logan', 1);
INSERT INTO Model values('Lodgy', 1);
INSERT INTO Model values('Sandero', 1);
INSERT INTO Model values('E-Class', 2);
INSERT INTO Model values('S-Class', 2);
INSERT INTO Model values('W124', 2);
INSERT INTO Model values('7 series', 3);
INSERT INTO Model values('5 series', 3);
INSERT INTO Model values('E38', 3);
INSERT INTO Model values('206', 4);
INSERT INTO Model values('508', 4);
INSERT INTO Model values('307', 4);
INSERT INTO Model values('Golf', 5);
INSERT INTO Model values('Passat', 5);
INSERT INTO Model values('Bora', 5);