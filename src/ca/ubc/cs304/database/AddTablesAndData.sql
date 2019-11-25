CREATE TABLE TimePeriod(
    fromDate VARCHAR(255),
    fromTime VARCHAR(255),
    toDate VARCHAR(255),
    toTime VARCHAR(255),
    PRIMARY KEY (fromDate, fromTime, toDate, toTime)
);

CREATE TABLE Customer(
    cellNum VARCHAR(255),
    name VARCHAR(255),
    address VARCHAR(255),
    driversLicense VARCHAR(255),
    PRIMARY KEY (driversLicense)
);

CREATE TABLE Branch(
    location VARCHAR(255),
    city VARCHAR(255),
    PRIMARY KEY (location, city)
);

CREATE TABLE VehicleType(
    VTName VARCHAR(255),
    features VARCHAR(255),
    weeklyRate INTEGER DEFAULT 1000,
    dailyRate INTEGER DEFAULT 100,
    hourlyRate INTEGER DEFAULT 10,
    weeklyInsuranceRate INTEGER DEFAULT 1000,
    dailyInsuranceRate INTEGER DEFAULT 100,
    hourlyInsuranceRate INTEGER DEFAULT 10,
    kmRate INTEGER DEFAULT 2,
    PRIMARY KEY (VTName)
);

CREATE TABLE ForRent(
    vID INTEGER,
    vLicense VARCHAR(255),
    make VARCHAR(255) DEFAULT 'Volkswagen',
    model VARCHAR(255) DEFAULT 'Beetle',
    year INTEGER DEFAULT 2000,
    color VARCHAR(255),
    odometer INTEGER DEFAULT 0,
    status VARCHAR(255),
    VTName VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    PRIMARY KEY (vLicense),
    FOREIGN KEY (location, city) REFERENCES Branch,
    FOREIGN KEY (VTName) REFERENCES VehicleType,
    CHECK (status = 'available' OR status = 'notavailable')
);

CREATE TABLE ForSale(
    vID      INTEGER,
    vFSLicense VARCHAR(255),
    make     VARCHAR(255),
    model    VARCHAR(255),
    year     INTEGER,
    color    VARCHAR(255),
    odometer INTEGER,
    status   VARCHAR(255),
    VTName   VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    city     VARCHAR(255) NOT NULL,
    PRIMARY KEY (vFSLicense),
    FOREIGN KEY (location, city) REFERENCES Branch,
    FOREIGN KEY (VTName) REFERENCES VehicleType,
    CHECK (status = 'available' OR status = 'notavailable')
);

CREATE TABLE Reservations(
    confNo INTEGER,
    VTName VARCHAR(255) NOT NULL,
    driversLicense VARCHAR(255) NOT NULL,
    fromDate VARCHAR(255),
    fromTime VARCHAR(255),
    toDate VARCHAR(255),
    toTime VARCHAR(255),
    location VARCHAR(255) NOT NULL,
    city     VARCHAR(255) NOT NULL,
    PRIMARY KEY (confNo),
    FOREIGN KEY (VTName) REFERENCES VehicleType,
    FOREIGN KEY (location, city) REFERENCES Branch,
    FOREIGN KEY (driversLicense) REFERENCES Customer,
    FOREIGN KEY (fromDate, fromTime, toDate, toTime) REFERENCES TimePeriod
);

CREATE TABLE Rental(
    rID INTEGER,
    vLicense VARCHAR(255) NOT NULL,
    driversLicense VARCHAR(255) NOT NULL,
    fromDate VARCHAR(255) NOT NULL,
    fromTime VARCHAR(255) NOT NULL,
    toDate VARCHAR(255) NOT NULL,
    toTime VARCHAR(255) NOT NULL,
    odometer INTEGER,
    cardName VARCHAR(255),
    cardNo INTEGER,
    expDate VARCHAR(255),
    confNo INTEGER,
    PRIMARY KEY (rID),
    FOREIGN KEY (vLicense) REFERENCES ForRent,
    FOREIGN KEY (driversLicense) REFERENCES Customer,
    FOREIGN KEY (fromDate, fromTime, toDate, toTime) REFERENCES TimePeriod,
    FOREIGN KEY (confNo) REFERENCES Reservations
);

CREATE TABLE Return(
    rID INTEGER,
    returnDate DATE,
    odometer INTEGER,
    fullTank NUMBER(1),
    value INTEGER,
    PRIMARY KEY (rID),
    FOREIGN KEY (rID) REFERENCES Rental
);

INSERT INTO Branch (location, city) VALUES ('shop_1', 'Vancouver');
INSERT INTO Branch (location, city) VALUES ('shop_2', 'Vancouver');
INSERT INTO Branch (location, city) VALUES ('shop_3', 'Vancouver');
INSERT INTO Branch (location, city) VALUES ('shop_1', 'Burnaby');
INSERT INTO Branch (location, city) VALUES ('shop_2', 'Burnaby');

INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (6041234567, 'John Smith', '1234 made up lane', '9282019');
INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (6041234567, 'Bob Smith', '1234 made up lane', '9272019');
INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (6041234567, 'Jo Smith', '1234 made up lane', '9262019');
INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (6041234567, 'Jon Smith', '1234 made up lane', '9252019');
INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (6041234567, 'Joh Smith', '1234 made up lane', '9242019');
INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (6041234567, 'J Smith', '1234 made up lane', '9232019');
INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (6041234567, 'Rob Smith', '1234 made up lane', '9222019');
INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (6041234567, 'Ro Smith', '1234 made up lane', '9212019');

INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (1234567890, 'Cane Able', '4312 does not exist', 'license_num');
INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (0109238881, 'Smith Apple', 'Disney Land Resort', 'q1238822');
INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (8388772838, 'Jonny Rocket', 'Tim Hortons', '920019293');
INSERT INTO Customer (cellNum, name, address, driversLicense)
VALUES (8289199482, 'Robert Frost', '9829 something road', '9maybe8912');

INSERT INTO VehicleType (VTName, features) VALUES ('SUV', 'car seat');
INSERT INTO VehicleType (VTName, features) VALUES ('truck', 'car seat');
INSERT INTO VehicleType (VTName, features) VALUES ('economy', 'car seat');
INSERT INTO VehicleType (VTName, features) VALUES ('compact', 'car seat');
INSERT INTO VehicleType (VTName, features) VALUES ('mid-size', 'car seat');
INSERT INTO VehicleType (VTName, features) VALUES ('standard', 'car seat');
INSERT INTO VehicleType (VTName, features) VALUES ('full-size', 'car seat');

INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10111', 'red', 'available', 'SUV', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10112', 'red', 'available', 'full-size', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10113', 'red', 'available', 'full-size', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10114', 'red', 'available', 'truck', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10115', 'red', 'available', 'truck', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10116', 'red', 'available', 'truck', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10117', 'red', 'available', 'economy', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10118', 'red', 'available', 'economy', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10119', 'red', 'available', 'economy', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10121', 'red', 'available', 'economy', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10122', 'red', 'available', 'mid-size', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (1,'A10123', 'red', 'available', 'SUV', 'shop_1', 'Vancouver');


INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (2, 'B10111', 'blue', 'available', 'truck', 'shop_2', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (3, 'C10111', 'green', 'available', 'standard', 'shop_1', 'Vancouver');
INSERT INTO ForRent (vID, vLicense, color, status, VTName, location, city)
VALUES (4, 'D10111', 'red', 'available', 'full-size', 'shop_1', 'Burnaby');
INSERT INTO ForSale (vID, vFSLicense, color, status, VTName, location, city)
VALUES (5, 'E10111', 'blue', 'available', 'economy', 'shop_1', 'Burnaby');


INSERT INTO TIMEPERIOD (fromDate, fromTime, toDate, toTime)
VALUES ('2019-11-24', '12:05', '2020-01-20', '1:00');

INSERT INTO TIMEPERIOD (fromDate, fromTime, toDate, toTime)
VALUES ('2019-11-20', '12:05', '2019-01-25', '1:00');

INSERT INTO TIMEPERIOD (fromDate, fromTime, toDate, toTime)
VALUES ('2019-11-26', '12:05', '2019-01-20', '1:00');

INSERT INTO TIMEPERIOD (fromDate, fromTime, toDate, toTime)
VALUES ('2019-11-27', '12:05', '2019-01-20', '1:00');


INSERT INTO Reservations (confNo, VTName, driversLicense, fromDate, fromTime, toDate, toTime, location, city)
VALUES (123, 'truck', '9282019', '2019-11-24', '12:05', '2020-01-20', '1:00', 'shop_1', 'Vancouver');


INSERT INTO Reservations (confNo, VTName, driversLicense, fromDate, fromTime, toDate, toTime, location, city)
VALUES (124, 'truck', '9282019', '2019-11-20', '12:05', '2019-01-25', '1:00', 'shop_1', 'Vancouver');

INSERT INTO Reservations (confNo, VTName, driversLicense, fromDate, fromTime, toDate, toTime, location, city)
VALUES (125, 'truck', '9272019', '2019-11-24', '12:05', '2020-01-20', '1:00', 'shop_1', 'Vancouver');

INSERT INTO Reservations (confNo, VTName, driversLicense, fromDate, fromTime, toDate, toTime, location, city)
VALUES (126, 'full-size', '9262019', '2019-11-24', '12:05', '2020-01-20', '1:00', 'shop_1', 'Vancouver');

INSERT INTO Reservations (confNo, VTName, driversLicense, fromDate, fromTime, toDate, toTime, location, city)
VALUES (127, 'full-size', '9252019', '2019-11-24', '12:05', '2020-01-20', '1:00', 'shop_1', 'Vancouver');

INSERT INTO Reservations (confNo, VTName, driversLicense, fromDate, fromTime, toDate, toTime, location, city)
VALUES (128, 'economy', '9242019', '2019-11-24', '12:05', '2020-01-20', '1:00', 'shop_1', 'Vancouver');

INSERT INTO Reservations (confNo, VTName, driversLicense, fromDate, fromTime, toDate, toTime, location, city)
VALUES (129, 'economy', '9232019', '2019-11-24', '12:05', '2020-01-20', '1:00', 'shop_1', 'Vancouver');

INSERT INTO Reservations (confNo, VTName, driversLicense, fromDate, fromTime, toDate, toTime, location, city)
VALUES (130, 'economy', '9222019', '2019-11-24', '12:05', '2020-01-20', '1:00', 'shop_1', 'Vancouver');

INSERT INTO Rental(rID ,vLicense, driversLicense , fromDate , fromTime, toDate, toTime, odometer,cardName,cardNo ,expDate, confNo)
                  VALUES (125, 'A10115', '9282019', '2019-11-20', '12:05', '2019-01-25', '1:00', 0, 'VISA', 123456, '02/21', 124);

INSERT INTO Rental(rID ,vLicense, driversLicense , fromDate , fromTime, toDate, toTime, odometer,cardName,cardNo ,expDate, confNo)
VALUES (126, 'A10116', '9282019', '2019-11-24', '12:05', '2020-01-20', '1:00', 0, 'VISA', 123456, '02/21', 125);

INSERT INTO Return( rID, returnDate, odometer, fullTank, value)
    VALUES(125, '2019-01-25', 5, 1, 510);