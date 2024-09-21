DROP TABLE IF EXISTS COUNTRY,
CITY,
AIRPORT,
AIRCRAFT,
FLIGHT,
FLIGHT_SUBSCRIPTION,
AIRLINE_AGENCY,
ACCOUNT,
PASSENGER;
DROP TYPE IF EXISTS GENDERS;

CREATE TABLE COUNTRY (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL PRIMARY KEY,
	CODE CHAR(2) NOT NULL UNIQUE,
	NAME TEXT NOT NULL
);

CREATE TABLE CITY (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL PRIMARY KEY,
	CODE CHAR(3) NOT NULL UNIQUE,
	NAME TEXT NOT NULL,
	COUNTRY_ID UUID REFERENCES COUNTRY (ID) NOT NULL
);

CREATE TABLE AIRPORT (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL PRIMARY KEY,
	NAME TEXT NOT NULL UNIQUE,
	SITE TEXT,
	CITY_ID UUID REFERENCES CITY (ID) NOT NULL
);

CREATE TABLE AIRCRAFT (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL PRIMARY KEY,
	NAME TEXT NOT NULL UNIQUE
);

CREATE TABLE AIRLINE_AGENCY (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL PRIMARY KEY,
	NAME TEXT NOT NULL UNIQUE,
	SITE TEXT
);

CREATE TABLE FLIGHT (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL PRIMARY KEY,
	ARRIVAL_DATE TIMESTAMP NOT NULL,
	DEPARTURE_DATE TIMESTAMP NOT NULL,
	PRICE INT NOT NULL,
	AIRCRAFT_ID UUID REFERENCES AIRCRAFT (ID) NOT NULL,
	AIRLINE_ID UUID REFERENCES AIRLINE_AGENCY (ID) NOT NULL,
	AIRPORT_ARRIVAL_ID UUID REFERENCES AIRPORT (ID) NOT NULL,
	AIRPORT_DEPARTURE_ID UUID REFERENCES AIRPORT (ID) NOT NULL
);

CREATE TABLE ACCOUNT (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL PRIMARY KEY,
	EMAIL TEXT NOT NULL UNIQUE,
	ACCOUNT_PASSWORD TEXT NOT NULL,
	CREATED_AT TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
);

CREATE TYPE GENDERS AS ENUM('MALE', 'FEMALE');

CREATE TABLE PASSENGER (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL PRIMARY KEY,
	FIRST_NAME TEXT NOT NULL,
	LAST_NAME TEXT NOT NULL,
	PATRONYMIC TEXT,
	BIRTH_DATE DATE NOT NULL,
	GENDER GENDERS NOT NULL,
	PASSPORT TEXT NOT NULL,
	ACCOUNT_ID UUID REFERENCES ACCOUNT (ID) NOT NULL
);

CREATE TABLE FLIGHT_SUBSCRIPTION (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL PRIMARY KEY,
	CREATED_AT TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
	NOTIFIED_AT TIMESTAMP,
	ACCOUNT_ID UUID REFERENCES ACCOUNT (ID) NOT NULL,
	FLIGHT_ID UUID REFERENCES FLIGHT (ID) NOT NULL
);