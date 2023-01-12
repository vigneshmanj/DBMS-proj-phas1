DROP DATABASE IF EXISTS airport_db;
CREATE DATABASE airport_db;
USE airport_db;

CREATE TABLE Aircraft(
Flight_ID varchar(10) PRIMARY KEY,
Route int NOT NULL);

CREATE TABLE Airport(
IATA_airport_codes varchar(3),
Time_Zone varchar(6),
Airport_Name varchar(25),
City varchar(25),
Country varchar(25),
Capacity int NOT NULL,
Flight_ID varchar(10),
PRIMARY KEY(IATA_airport_codes,Flight_ID),
FOREIGN KEY(Flight_ID) REFERENCES Aircraft (Flight_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Terminal(
Terminal_ID int(10) PRIMARY KEY,
IATA_airport_codes varchar(3),
Airplane_Handling BIGINT(10),
Boarding_Time DATETIME,
FOREIGN KEY(IATA_airport_codes) REFERENCES Airport(IATA_airport_codes) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE PNRINFO(
PNR_number varchar(6) PRIMARY KEY,
Terminal_ID int(10),
class varchar(10),
FOREIGN KEY (Terminal_ID) REFERENCES Terminal (Terminal_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Passenger(
Aadhar varchar(12) PRIMARY KEY,
PNR_number varchar(6),
Name varchar(255) NOT NULL,
Gender enum('Male', 'Female', 'Others'),
House_Number varchar(10),
Building varchar(255),
City varchar(255),
Nationality varchar(255),
FOREIGN KEY (PNR_number) REFERENCES PNRINFO(PNR_number) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Boardingpass(
Barcode_number varchar(12) PRIMARY KEY,
PNR_number varchar(6),
Seat varchar(5) NOT NULL,
Flight_ID varchar(10),
FOREIGN KEY (Flight_ID) REFERENCES Aircraft(Flight_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (PNR_number) REFERENCES PNRINFO(PNR_number) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE luggage(
Baggage_ID bigint(10) PRIMARY KEY,
Barcode_number varchar(12),
Flight_ID varchar(10),
FOREIGN KEY (Flight_ID) REFERENCES Aircraft(Flight_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(Barcode_number) REFERENCES Boardingpass(Barcode_number) ON DELETE CASCADE ON UPDATE CASCADE
);
