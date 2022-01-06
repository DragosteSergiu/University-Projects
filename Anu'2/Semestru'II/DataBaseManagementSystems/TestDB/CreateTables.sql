USE [TestDBMS]


CREATE TABLE Producer(
	id INT PRIMARY KEY IDENTITY,
	first_name varchar(255),
	last_name varchar(255),
	nationality varchar(255),
	number_of_awards int
)

CREATE TABLE MovieCategory(
	id INT PRIMARY KEY IDENTITY,
	category_name varchar(255),
	category_description varchar(255)
)


CREATE TABLE Movie(
	movie_id INT PRIMARY KEY IDENTITY,
	title varchar(255),
	producer_id INT FOREIGN KEY REFERENCES Producer(id) ON DELETE CASCADE,
	category_id INT FOREIGN KEY REFERENCES MovieCategory(id) ON DELETE CASCADE
);

--a has a name, location and number of seats
CREATE TABLE Cinema(
	cinema_id INT PRIMARY KEY IDENTITY,
	location varchar(255),
	number_of_seats int
);

CREATE TABLE Schedule(
	movie_id INT REFERENCES Movie(movie_id) ON DELETE CASCADE,
	cinema_id INT REFERENCES Cinema(cinema_id) ON DELETE CASCADE,
	PRIMARY KEY(movie_id, cinema_id),
	startAt datetime,
	tickets_sold int
);