CREATE DATABASE IF NOT EXISTS `PickApp` DEFAULT CHARACTER SET = 'utf8' DEFAULT COLLATE 'utf8_general_ci';

USE PickApp;
#Users table
CREATE TABLE IF NOT EXISTS `Users` (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  phone_number VARCHAR(255) NOT NULL
);

#Drivers Table
CREATE TABLE IF NOT EXISTS `Drivers` (
  driver_id INT AUTO_INCREMENT PRIMARY KEY,
  driver_name VARCHAR(255) NOT NULL,
  driver_email VARCHAR(255) NOT NULL,
  driver_phone_number VARCHAR(255) NOT NULL,
  driver_license_number VARCHAR(255) NOT NULL
);
#Type of ride Table
CREATE TABLE IF NOT EXISTS `TypeOfRide` ( 
  ride_id INT AUTO_INCREMENT PRIMARY KEY , 
  ride_name VARCHAR(255) NOT NULL
);

#Vehicle Brands table
CREATE TABLE IF NOT EXISTS `VehicleBrands` ( 
  brand_id INT AUTO_INCREMENT PRIMARY KEY , 
  brand_name VARCHAR(255) NOT NULL
);

#Vehicle Models Table
CREATE TABLE IF NOT EXISTS `VehicleModels` ( 
  model_id INT AUTO_INCREMENT PRIMARY KEY , 
  brand_id INT,
  model_name VARCHAR(255) NOT NULL,
  model_type VARCHAR(255) NOT NULL,
  FOREIGN KEY (brand_id) REFERENCES VehicleBrands(brand_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

#Vehicles Table
CREATE TABLE IF NOT EXISTS `Vehicles` ( 
  vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
  driver_id INT,
  vehicle_plate_number VARCHAR(255) NOT NULL,
  vehicle_year INT NOT NULL,
  vehicle_model_id INT,
  vehicle_type_id INT, 
  FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (vehicle_model_id) REFERENCES VehicleModels(model_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (vehicle_type_id) REFERENCES TypeOfRide(ride_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
#Country Table
CREATE TABLE IF NOT EXISTS `Country` (
country_id INT AUTO_INCREMENT PRIMARY KEY,
name_country VARCHAR(255) NOT NULL
);
#City tables
CREATE TABLE IF NOT EXISTS `City` (
city_id INT AUTO_INCREMENT PRIMARY KEY,
name_city VARCHAR(255) NOT NULL,
country_id INT,
FOREIGN KEY (country_id) REFERENCES PickApp.country(country_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
#Payment Methods table
CREATE TABLE IF NOT EXISTS `PaymentMethods` (
  paymentMethod_id INT AUTO_INCREMENT PRIMARY KEY,
  payment_name VARCHAR (255) NOT NUll,
  user_id INT NOT NULL,
  card_number VARCHAR(255),
  expiration_date VARCHAR(255),
  cvv VARCHAR(255),
FOREIGN KEY (user_id) REFERENCES Users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT
);



#Promotions Table
CREATE TABLE IF NOT EXISTS `Promotions` (
  promotion_id INT AUTO_INCREMENT PRIMARY KEY,
  promotion_code VARCHAR(255) NOT NULL,
  promotion_description VARCHAR(255) NOT NULL,
  promotion_discount DECIMAL(10, 2) NOT NULL,
  promotion_expiration_date DATE NOT NULL
);
#Promo Table
CREATE TABLE IF NOT EXISTS `UserPromos` (
    user_promo_id INT  AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    promotion_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (promotion_id) REFERENCES Promotions(promotion_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
#Trips Table
CREATE TABLE IF NOT EXISTS `Trips` (
    trip_id INT PRIMARY KEY,
    driver_id INT NOT NULL,
    user_id INT NOT NULL,
    payment_method_id INT NOT NULL,
    promotions_id INT ,  
    start_city_id INT NOT NULL,
    end_city_id INT NOT NULL,
    ride_status varchar(255) not null,
    fare DECIMAL(10, 2) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (payment_method_id) REFERENCES PaymentMethods(paymentMethod_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (promotions_id) REFERENCES Promotions(promotion_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (start_city_id) REFERENCES  City(city_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (end_city_id) REFERENCES City(city_id) ON UPDATE CASCADE ON DELETE RESTRICT
    );
#User Ratings table
CREATE TABLE IF NOT EXISTS `User_Ratings` (
  user_rating_id INT AUTO_INCREMENT PRIMARY KEY,
  trip_id INT,
  user_rating_score INT NOT NULL,
  user_rating_comment VARCHAR(255),
  user_rating_date DATETIME NOT NULL,
  FOREIGN KEY (trip_id) REFERENCES Trips(trip_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
#Driver Rating table
CREATE TABLE IF NOT EXISTS `Driver_Ratings` (
  driver_rating_id INT AUTO_INCREMENT PRIMARY KEY,
  trip_id INT,
  driver_rating_score INT NOT NULL,
  driver_rating_comment VARCHAR(255),
  driver_rating_date DATETIME NOT NULL,
  FOREIGN KEY (trip_id) REFERENCES Trips(trip_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
#Log table
CREATE TABLE IF NOT EXISTS Log (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(255) not null,
  event_type VARCHAR(255) NOT NULL,
  event_data VARCHAR(255) NOT NULL,
  log_date DATETIME NOT NULL
);

#Trip Log table
CREATE TABLE IF NOT EXISTS `TripLogs` (
  trip_log_id INT AUTO_INCREMENT PRIMARY KEY,
  trip_id INT,
  trip_log_event VARCHAR(255) NOT NULL,
  trip_log_message VARCHAR(255) NOT NULL,
  log_entry_date TIMESTAMP,
  FOREIGN KEY (trip_id) REFERENCES Trips(trip_id) ON UPDATE CASCADE ON DELETE RESTRICT
);





###INSERT DATA ######

INSERT INTO Users (username, email, password, phone_number) VALUES
('Keandre Bradley', 'keandre-bradley87@aol.com', 'password1', '1234567890'),
('Devon Burt', 'devon-burt77@gmail.com', 'password2', '9876543210'),
('Zoie Blevins', 'zoie_blevins32@outlook.com', 'password3', '5678901234'),
('Yvonne Pearson', 'pearson_yvonne78@gmail.com', 'password4', '6583941126'),
('Brad Birdie', 'bradfordbirdie@gmail.com', 'password5', '9876543210'),
('isiah Simone', 'isiah_sims63@outlook.com', 'password6', '8499375201'),
('Shean Harley', 'sheehan-shea82@gmail.com', 'password7', '7728339011'),
('Martin Davenport', 'marty_davenport25@aol.com', 'password8', '9300284367'),
('Braedon Dunlap', 'braedon_dunlap56@yahoo.com', 'password9', '2791334670'),
('Melendez Garth', 'melendezgarth15@outlook.com', 'password10', '1234554367'),
('Eldred Moss', 'moss-eldred60@yahoo.com', 'password11', '4379220438'),
('Camoron Oterio', 'cameron-otero83@yahoo.com', 'password12', '4833579120'),
('Therese Tuttle', 'therese_tuttle79@yahoo.comm', 'password13', '8993456721'),
('Kailey Andreas', 'skinner-kailey95@yahoo.com', 'password14', '7568324955'),
('Silvia Duncan', 'duncan_silvia3@outlook.com', 'password15', '6238734653'),
('Arthur Cox', 'croucharthur59@aol.com', 'password16', '3885942875'),
('Mark Foreman', 'foreman_marquise31@aol.com', 'password17', '1879254367'),
('Niel Reynold', 'nielsen-reynold39@aol.com', 'password18', '6773904551'),
('Mary Brough', 'yarbroughmary@mail.com', 'password19', '2774965331'),
('Katina Tyler', 'katina_tyler55@mail.com', 'password20', '2739940128'),
('Barney Fireman', 'barney_carrasco24@gmail.com', 'password21', '8463390265'),
('Nicolas Estrada', 'nico-estrada58@outlook.com', 'password22', '7739204374'),
('John Belcher', 'johnathon_belcher92@yahoo.com', 'password23', '3784204839'),
('Tate Randel', 'tate_randell88@outlook.com', 'password24', '7439054320'),
('Alexa Goldman', 'alexa-goldman71@yahoo.com', 'password25', '8394028302'),
('Melodie Mcmillan', 'mcmillan-melodie38@outlook.com', 'password26', '99203345582');

INSERT INTO Drivers (driver_name, driver_email, driver_phone_number, driver_license_number) VALUES
('Samantha Huff', 'samantha-huff76@PickApp.com', '9102738239', 'DL123456'),
('Choi Lu', 'choi_luanne69@PickApp.com', '2783349102', 'DL654321'),
('Will Wesley', 'willie_wesley18@PickApp.com', '3782294731', 'DL987654'),
('Joy Cannon', 'cannon-joy68@PickApp.com', '4738543261', 'DL4788326'),
('Cedric Perez', 'cedric_perez36@PickApp.com', '7894453622', 'DL923745'),
('Clinton Hansen', 'clinton-hansen74@PickApp.com', '2338245667', 'DL876549'),
('Mickey Burmen', 'mickey_bui40@PickApp.com', '172883432', 'DL324651'),
('Lennon Odell', 'lennon_odell16@PickApp.com', '2273894233', 'DL543264'),
('Audry Lee', 'le_audie12@PickApp.com', '7456638920', 'DL955124'),
('Orlando Moody', 'moody-orlando93@PickApp.com', '9003564278', 'DL647389'),
('Harrison Odonell', 'odonnell-harrison57@PickApp.com', '8347759234', 'DL432165'),
('Gigi Jarrell', 'gee_jarrell95@PickApp.com', '6473829923', 'DL876549'),
('Bertha Houser', 'bertha-houser12@PickApp.com', '9228463371', 'DL235614'),
('Ben Dahl', 'benita-dahl15@PickApp.com', '8293463382', 'DL563478'),
('Marvin Valentin', 'marin-valentin34@PickApp.com', '7483291399', 'DL873645'),
('Susan Cherry', 'susan-cherry70@PickApp.com', '4475382237', 'DL904318'),
('Loraline Smith', 'lora_smith21@PickApp.com', '2833377492', 'DL192283'),
('Nelson Phoenix', 'phoenix_nelson43@PickApp.com', '3628829433', 'DL092318'),
('Ismael Delatorre', 'ismael_delatorre38@PickApp.com', '4457952831', 'DL302688'),
('Ella Leung', 'ella_leung5@PickApp.com', '7973002384', 'DL005619'),
('Brittany Mason', 'mason_brittany89@PickApp.com', '9342944193', 'DL946284'),
('Drake Jacke', 'jackeline_drake87@PickApp.com', '8934220129', 'DL107732'),
('Trevor Kinney', 'kinney_trevor16@PickApp.com', '8249240218', 'DL883452'),
('Courtney Valerie', 'courtneyvalerie84@PickApp.com', '983950023', 'DL783542'),
('Chandler Bing', 'chandlermuriel@PickApp.com', '1925348393', 'DL281023'),
('Joey King', 'kingjoey78@PickApp.com', '8394234432', 'DL618835');

INSERT INTO TypeOfRide (ride_name) VALUES 
('Vehicle_X'),
('Vehicle_XL'),
('Vehicle_Black'),
('Vehicle_VIP');

INSERT INTO VehicleBrands (brand_name) VALUES 
('Toyota'),
('Honda'),
('Ford'),
('Chevrolet'),
('Renault'),
('Tesla'),
('Kia'),
('Fiat'),
('Hyundai');

INSERT INTO VehicleModels (brand_id, model_name, model_type) VALUES
(1, 'Camry', 'Sedan'),
(1, 'RAV4', 'SUV'),
(2, 'Civic', 'Sedan'),
(2, 'CR-V', 'SUV'),
(3, 'Focus', 'Hatchback'),
(3, 'Escape', 'SUV'),
(4, 'Malibu', 'Sedan'),
(4, 'Equinox', 'SUV'),
(5, 'Clio', 'Sedan'),
(6, 'Model X', 'Sedan'),
(7, 'RIO', 'SUV'  ),
(8, 'Panda', 'Sedan'),
(9, 'I20', 'SUV');

INSERT INTO Vehicles (driver_id, vehicle_plate_number, vehicle_year, vehicle_model_id, vehicle_type_id) VALUES
(1, '8ANK075', 2018, 2, 2),
(2, 'A99HLD', 2019, 4, 3),
(3, 'GHI789', 2020, 5, 1),
(4, 'JKL012', 2017, 6, 3),
(5, 'MNO345', 2021, 8, 2),
(6, 'PQR678', 2016, 10, 4),
(7, 'STU901', 2019, 12, 1),
(8, 'VWX234', 2017, 13, 3),
(9, 'YZA567', 2020, 1, 2),
(10, 'BCD890', 2018, 3, 4),
(11, 'EFG123', 2019, 8, 1),
(12, 'HIJ456', 2020, 6, 3),
(13, 'KLM789', 2017, 9, 2),
(14, 'NOP012', 2021, 7, 4),
(15, 'QRS345', 2016, 11, 1),
(16, 'TUV678', 2019, 10, 3),
(17, 'WXY901', 2017, 1, 2),
(18, 'ZAB234', 2020, 2, 4),
(19, 'CDE567', 2018, 4, 1),
(20, 'FGH890', 2019, 6, 3),
(21, 'IJK123', 2020, 4, 2),
(22, 'LMN456', 2017, 12, 4),
(23, 'ABC123', 2020, 1, 1),
(24, 'XYZ789', 2019, 3, 2),
(25, 'JKL456', 2021, 7, 3),
(26, 'MNO789', 2020, 4, 2);
#Sample Burcu add


INSERT INTO Country (name_country) VALUES 
('Argentina'),
('Australia'),
('Brazil'),
('Canada'),
('Colombia'),
('Czech Republic'),
('Estonia'),
('France'),
('Germany'),
('Ireland'),
('Italy'),
('Japan'),
('Lithuania'),
('Netherlands'),
('New Zealand'),
('Poland'),
('Portugal'),
('Qatar'),
('Slovakia'),
('Spain'),
('Sweden'),
('Turkey'),
('Ukraine'),
('United Kingdom'),
('United States'),
('Uruguay');

INSERT INTO City (name_city, country_id) VALUES
('Buenos Aires', 1),
('Sydney', 2),
('Rio De Janeiro', 3),
('Toronto', 4),
('Bogota', 5),
('Medellin', 5),
('Cartagena', '5'),
('Barranquilla','5'),
('Prague', 6),
('Tallinn', 7),
('Paris', 8),
('Stuttgart', 9),
('Dublin', 10),
('Milan', 11),
('Tokyo', 12),
('Vilnius', 13),
('Amsterdam', 14),
('Auckland', 15),
('Warsaw', 16),
('Lisbon', 17),
('Doha', 18),
('Bratislava', 19),
('Madrid', 20),
('Stockholm', 21),
('Istanbul', 22),
('Kyiv', 23),
('London', 24),
('Seattle', 25),
('Punta del Este', 26);

## They are all the same

#1 Debit #2 Credit card
INSERT INTO PaymentMethods (payment_name,user_id,card_number,expiration_date,cvv) VALUES
( 'Debit Card', 1,'1111222233334444', '12/24', '123'),
('Credit card',2 ,'7854139812003', '12/27', '789'),
('Credit card', 3,'024961233874', '10/24', '736'),
('Debit Card', 4,'559630783542', '07/24', '368'),
('Debit Card',5 ,'000333541269', '09/25', '852'),
('Credit card',6,'650039825601', '02/24', '741'),
( 'Debit Card', 7,'96841058124', '06/24', '963'),
('Debit Card',8 ,'632987420065', '01/27', '684'),
('Debit Card',9 ,'003698874222', '12/27', '426'),
( 'Credit card', 10,'931268859323', '11/24', '751'),
('Debit Card',11 ,'197326687203', '11/26', '359'),
('Debit Card',12 ,'036997208640', '05/26', '712'),
( 'Credit card', 13,'963196674428', '03/24', '932'),
('Debit Card',14 ,'900239755630', '04/25', '087'),
('Credit card',15 ,'103874069905', '11/27', '901'),
('Credit card', 16,'324474566081', '12/26', '932'),
('Credit card',17 ,'220174136082', '01/26', '159'),
('Debit Card',18 ,'853041075264', '09/25', '753'),
('Credit card', 19,'412079304552', '12/27', '820'),
('Debit Card',20 ,'520078896321', '09/24', '710'),
('Debit Card',21 ,'203087402659', '08/25', '039')
;

INSERT INTO Promotions (promotion_code, promotion_description, promotion_discount, promotion_expiration_date) VALUES
('PickAppNEWUSER', '10% off Your First PickApp Ride', 0.10, '2023-02-28'),
('PickApp30OFF', '30% off Your Next PickApp Ride', 0.30, '2023-05-28'),
('PickAppAPPRECIATION', 'Customer Appreciation Day - 15% off Your PickApp Ride', 0.15, '2023-12-28'),
('PickAppHALFPRICE', 'Buy One PickApp Ride, Get Second Half Price', 0.50, '2022-09-19'),
('PickAppHALFPRICE', 'Buy One PickApp Ride, Get Second Half Price', 0.50, '2020-08-22'),
('PickAppNEWUSER', '10% off Your First PickApp Ride', 0.10, '2022-12-31'),
('PickAppHALFPRICE', 'Buy One PickApp Ride, Get Second Half Price', 0.50, '2021-05-22'),
('PickAppAPPRECIATION', 'Customer Appreciation Day - 15% off Your PickApp Ride', 0.15, '2020-11-10'),
('PickAppAPPRECIATION', 'Customer Appreciation Day - 15% off Your PickApp Ride', 0.15, '2022-09-22'),
('PickApp20OFF', '20% off Your Next PickApp Ride', 0.20, '2022-07-30'),
('PickApp30OFF', '30% off Your Next PickApp Ride', 0.30, '2022-05-04'),
('PickAppFLASH', 'PickApp Flash Sale - 24-Hour Discount', 0.20, '2020-03-20'),
('PickAppNEWUSER', '10% off Your First PickApp Ride', 0.10, '2021-02-12'),
('PickAppHALFPRICE', 'Buy One PickApp Ride, Get Second Half Price', 0.50, '2021-09-02'),
('PickApp20OFF', '20% off Your Next PickApp Ride', 0.20, '2022-09-15'),
('PickAppAPPRECIATION', 'Customer Appreciation Day - 15% off Your PickApp Ride', 0.15, '2020-02-08'),
('PickAppFLASH', 'PickApp Flash Sale - 24-Hour Discount', 0.20, '2022-04-18'),
('PickApp20OFF', '20% off Your Next PickApp Ride', 0.20, '2021-10-15'),
('PickAppNEWUSER', '10% off Your First PickApp Ride', 0.10, '2020-12-31'),
('PickAppHALFPRICE', 'Buy One PickApp Ride, Get Second Half Price', 0.50, '2021-02-16'),
('PickAppAPPRECIATION', 'Customer Appreciation Day - 15% off Your PickApp Ride', 0.15, '2021-10-18'),
('PickAppFLASH', 'PickApp Flash Sale - 24-Hour Discount', 0.20, '2021-11-21'),
('PickAppNEWUSER', '10% off Your First PickApp Ride', 0.10, '2022-06-11'),
('PickAppAPPRECIATION', 'Customer Appreciation Day - 15% off Your PickApp Ride', 0.15, '2020-06-06'),
('PickAppAPPRECIATION', 'Customer Appreciation Day - 15% off Your PickApp Ride', 0.15, '2020-11-10');


INSERT INTO UserPromos (user_id, promotion_id) VALUES
(1, 1),
(1, 2),
(3, 7),
(2, 5),
(5, 4),
(2, 7),
(6, 10),
(8, 3),
(9, 6),
(4, 11),
(7, 13),
(11, 9),
(5, 12),
(13, 8),
(15, 17),
(16, 14),
(8, 16),
(10, 6),
(14, 13),
(8, 20),
(26, 7),
(21, 11),
(18, 24),
(23, 25),
(19, 22),
(16, 6),
(20, 17);

#20 more add atleast arrange of 2 years on this trips
INSERT INTO Trips (trip_id, driver_id, user_id, payment_method_id,promotions_id, start_city_id, end_city_id, ride_status, fare, start_time, end_time)
VALUES
(1, 1, 1, 1, 1, 1, 1, 'Completed', 25.50, '2021-01-01 08:00:00', '2021-01-01 08:30:00'),
(2, 2, 2, 2, 1, 3, 3, 'Cancelled', 0, '2021-02-05 10:00:00', '2021-02-05 10:30:00'),
(3, 3, 3, 3, 1, 5, 5, 'Completed', 30.20, '2021-03-10 12:00:00', '2021-03-10 12:30:00'),
(4, 4, 4, 1, 1, 7, 7, 'Completed', 18.90, '2021-04-15 14:00:00', '2021-04-15 14:30:00'),
(5, 5, 5, 2, 1, 10, 10, 'Cancelled', 0, '2021-05-20 16:00:00', '2021-05-20 16:30:00'),
(6, 6, 6, 2, 1, 2, 2, 'Completed', 22.40, '2021-06-25 18:00:00', '2021-06-25 18:30:00'),
(7, 7, 7, 1, 1, 11, 11, 'Completed', 27.80, '2021-07-01 20:00:00', '2021-07-01 20:30:00'),
(8, 8, 8, 2, 1, 13, 13, 'Cancelled', 0, '2021-08-04 22:00:00', '2021-08-04 22:30:00'),
(9, 9, 9, 3, 1, 15, 15, 'Completed', 35.60, '2021-09-10 00:00:00', '2021-09-10 00:30:00'),
(10, 10, 10, 1, 1, 18, 18, 'Completed', 21.75, '2021-10-15 02:00:00', '2021-10-15 02:30:00'),
(11, 11, 11, 2, 1, 19, 19, 'Cancelled', 0, '2021-11-20 04:00:00', '2021-11-20 04:30:00'),
(12, 12, 12, 2, 1, 22, 22, 'Completed', 29.90, '2021-12-25 06:00:00', '2021-12-25 06:30:00'),
(13, 13, 13, 1, 1, 24, 24, 'Completed', 19.50, '2022-01-01 08:00:00', '2022-01-01 08:30:00'),
(14, 14, 14, 2, 1, 26, 26, 'Cancelled', 0, '2022-02-05 10:00:00', '2022-02-05 10:30:00'),
(15, 15, 15, 3, 1, 17, 17, 'Completed', 24.75, '2022-03-10 12:00:00', '2022-03-10 12:30:00'),
(16, 16, 16, 1, 1, 9, 9, 'Completed', 18.20, '2022-04-15 14:00:00', '2022-04-15 14:30:00'),
(17, 17, 17, 2, 1, 8, 8, 'Cancelled', 0, '2022-05-20 16:00:00', '2022-05-20 16:30:00'),
(18, 18, 18, 2, 1, 12, 12, 'Completed', 26.40, '2022-06-25 18:00:00', '2022-06-25 18:30:00'),
(19, 19, 19, 1, 1, 21, 21, 'Completed', 30.10, '2022-07-01 20:00:00', '2022-07-01 20:30:00'),
(20, 20, 20, 3, 1, 16, 16, 'Cancelled', 0, '2022-08-04 22:00:00', '2022-08-04 22:30:00'),
(21, 21, 21, 1, 1, 14, 14, 'Completed', 22.90, '2022-09-10 00:00:00', '2022-09-10 00:30:00'),
(22, 22, 22, 2, 1, 9, 9, 'Completed', 17.80, '2022-10-15 02:00:00', '2022-10-15 02:30:00'),
(23, 23, 23, 2, 1, 19, 19, 'Cancelled', 0, '2022-11-20 04:00:00', '2022-11-20 04:30:00'),
(24, 24, 24, 3, 1, 8, 8, 'Completed', 25.25, '2022-12-25 06:00:00', '2022-12-25 06:30:00'),
(25, 25, 25, 1, 1, 24, 24, 'Completed', 20.60, '2023-01-01 08:00:00', '2023-01-01 08:30:00'),
(26, 26, 26, 2, 1, 26, 26, 'Cancelled', 0, '2023-02-05 10:00:00', '2023-02-05 10:30:00');



INSERT INTO User_Ratings (trip_id, user_rating_score, user_rating_comment, user_rating_date) VALUES
(1, 5, 'Great trip!', '2021-01-01 08:35:00'),
(2, 4, 'Enjoyable experience', '2021-02-05 10:35:00'),
(3, 3, 'Average trip', '2021-03-10 12:35:00'),
(4, 2, 'Disappointing', '2021-04-15 14:35:00'),
(5, 5, 'Highly recommend', '2021-05-20 16:35:00'),
(6, 4, 'Lovely customer', '2021-06-25 18:35:00'),
(7, 3, 'Could have been better', '2021-07-01 20:35:00'),
(8, 2, 'Not worth the price', '2021-08-04 22:35:00'),
(9, 5, 'Best trip ever!', '2021-09-10 00:35:00'),
(10, 4, 'Memorable experience', '2021-10-15 02:35:00'),
(11, 3, 'Decent tour', '2021-11-20 04:35:00'),
(12, 2, 'Poor experience', '2021-12-25 06:35:00'),
(13, 5, 'Absolutely amazing!', '2022-01-01 08:35:00'),
(14, 4, 'Great customer!', '2022-02-05 10:35:00'),
(15, 3, 'Nice!', '2022-03-10 12:35:00'),
(16, 2, 'Not what I expected', '2022-04-15 14:35:00'),
(17, 5, 'Unforgettable experience!', '2022-05-20 16:35:00'),
(18, 4, 'Knowledgeable guide', '2022-06-25 18:35:00'),
(19, 3, 'Average trip', '2022-07-01 20:35:00'),
(20, 2, 'Waste of money', '2022-08-04 22:35:00'),
(21, 5, 'Highly recommend', '2022-09-10 00:35:00'),
(22, 4, 'Great experience!', '2022-10-15 02:35:00'),
(23, 3, 'Bad trip!', '2022-11-20 04:35:00'),
(24, 2, 'Disappointing experience', '2022-12-25 06:35:00'),
(25, 5, 'Highly recommend!', '2023-01-01 08:35:00'),
(26, 4, 'Wonderful trip', '2023-02-05 10:35:00');

#David
INSERT INTO Driver_Ratings (trip_id, driver_rating_score, driver_rating_comment, driver_rating_date) VALUES
(1, 4,  'Good ride', '2021-01-01 08:35:00'),
(2, 5, 'Great ride', '2021-02-05 10:35:00'),
(3, 3, 'Average ride', '2021-03-10 12:35:00'),
(4, 4, 'Good ride', '2021-04-15 14:35:00'),
(5, 5, 'Great ride', '2021-05-20 16:35:00'),
(6, 3, 'Average ride', '2021-06-25 18:35:00'),
(7, 4, 'Good ride', '2021-07-01 20:35:00'),
(8, 5, 'Great ride', '2021-08-04 22:35:00'),
(9, 3, 'Average ride', '2021-09-10 00:35:00'),
(10, 4, 'Good ride', '2021-10-15 02:35:00'),
(11,  5, 'Great ride', '2021-11-20 04:35:00'),
(12, 3, 'Average ride', '2021-12-25 06:35:00'),
(13, 4, 'Good ride', '2022-01-01 08:35:00'),
(14, 5, 'Great ride', '2022-02-05 10:35:00'),
(15, 3, 'Average ride', '2022-03-10 12:35:00'),
(16, 4, 'Good ride', '2022-04-15 14:35:00'),
(17, 5, 'Great ride', '2022-05-20 16:35:00'),
(18, 3, 'Average ride', '2022-06-25 18:35:00'),
(19, 4, 'Good ride', '2022-07-01 20:35:00'),
(20, 5, 'Great ride', '2022-08-04 22:35:00'),
(21,  3, 'Average ride', '2022-09-10 00:35:00'),
(22, 4, 'Good ride', '2022-10-15 02:35:00'),
(23, 5, 'Great ride', '2022-11-20 04:35:00'),
(24, 3, 'Average ride', '2022-12-25 06:35:00'),
(25, 4, 'Good ride', '2023-01-01 08:35:00'),
(26, 5, 'Great ride', '2023-02-05 10:35:00');



INSERT INTO Log (event_type,user_name, event_data, log_date) VALUES 
('User Login', 'john2','John123 logged in', NOW()),
('User Login', 'john2','John123 logged in', NOW());

INSERT INTO TripLogs (trip_id, trip_log_event, trip_log_message, log_entry_date) VALUES 
(1, 'event', 'Updated',  '2021-12-01 08:00:00');

#####------------------TRIGGERS----------------------------------------------#####

#UPDATES if a user cancel rides to trip logs#####
DELIMITER //
CREATE TRIGGER Insert_Cancel_RIDE
    AFTER UPDATE ON PickApp.trips
    FOR EACH ROW 
BEGIN
   DECLARE ride_status VARCHAR(255);
   SELECT ride_status INTO ride_status FROM Pickapp.trips WHERE trip_id = NEW.trip_id;
   if NEW.ride_status = 'Cancelled'
   then
       INSERT PickApp.triplogs(trip_id, trip_log_event, trip_log_message, log_entry_date)
       VALUES (NEW.trip_id , 'Cancelled', 'The user decided to cancel de ride', NOW()) ;
    end if ;
END ;
// DELIMITER ;

###Updates to last day of rid#####
DELIMITER //
CREATE TRIGGER Update_trips_date
BEFORE UPDATE ON PickApp.trips
FOR EACH ROW 
BEGIN
   IF NEW.ride_status = 'Completed' AND OLD.ride_status != 'Completed' THEN
       SET NEW.end_time = NOW();
   END IF;
END;
//DELIMITER ;



#####----------------For checking the triggers------------------####

##First trigger###
#Check if info on trips log added#
SELECT * FROM TripLogs;

UPDATE PickApp.trips as t
SET t.ride_status = 'Cancelled'
WHERE t.trip_id = 8;

SELECT * FROM TripLogs;

###Second Trigger###
#Check if date updated to now#
SELECT * FROM trips;

UPDATE PickApp.trips as t
SET t.ride_status = 'Progress'
WHERE t.trip_id = 3;

UPDATE PickApp.trips as t
SET t.ride_status = 'Completed'
WHERE t.trip_id = 3;

Select * FROM trips;

##-------------------------------- QUERIES---------------------------##

use PickApp;

### First Query, service info between a range of dates#####
SELECT username, t.start_time, ty.ride_name FROM PickApp.users as u
JOIN trips as t on t.user_id = u.user_id
JOIN drivers as d on d.driver_id = t.driver_id 
JOIN vehicles as v on d.driver_id = v.driver_id 
JOIN typeofride as ty on ty.ride_id = v.vehicle_type_id
WHERE t.start_time BETWEEN '2020-12-31' AND '2022-12-31';


#Second Query
#THREE BEST CUSTOMERS
SELECT AVG(ur.user_rating_score) as scores, u.username FROM User_Ratings as ur 
JOIN trips as t ON t.trip_id = ur.trip_id
JOIN Users as u ON u.user_id = t.user_id
GROUP BY u.username
ORDER BY scores DESC LIMIT 3;

#Third Query give total average year and month between a range of date#
SELECT 
'12/2020 - 12/2022' as PeriodOfSales,
CONCAT(ROUND(AVG(YearlyTotal),2), ' €') AS YearlyAverage,
CONCAT(ROUND(AVG(MonthlyTotal),2),' €') AS MonthlyAverage,
CONCAT(SUM(TotalSales), ' €') AS TotalSales
FROM (
  SELECT 
    YEAR(t.start_time) AS Year,
    MONTH(t.start_time) AS Month,
    SUM(t.fare) AS TotalSales,
    AVG(t.fare) AS MonthlyTotal,
    SUM(SUM(t.fare)) OVER (PARTITION BY YEAR(t.start_time)) AS YearlyTotal
  FROM trips as t
  WHERE t.start_time BETWEEN '2020-12-31' AND '2022-12-31' AND t.ride_status = 'Completed'
  GROUP BY YEAR(t.start_time), MONTH(t.start_time)
) AS subquery;

#4th query find services based on address this case city is our address#
SELECT SUM(t.fare) as Total_Sales, co.name_country as Country_Name, c.name_city as City_Name FROM trips as t 
JOIN city as c ON  c.city_id = t.start_city_id
JOIN country as co ON co.country_id = c.country_id
WHERE t.ride_status = 'Completed'
GROUP BY c.name_city, co.name_country ;

## Give the countries and city that a trip and the driver has been rated###
SELECT co.name_country as Country_Name, c.name_city as City_Name FROM trips as t 
JOIN city as c ON  c.city_id = t.start_city_id
JOIN country as co ON co.country_id = c.country_id
JOIN drivers as d ON d.driver_id = t.driver_id
JOIN driver_ratings as dr ON dr.trip_id = t.trip_id
WHERE t.ride_status = 'Completed' AND dr.driver_rating_score >= 0
GROUP BY c.name_city, co.name_country; 


###------------------INVOICE VIEWS -----------------------------#

## First view of user info##
CREATE VIEW PickAppCustomers AS 
SELECT 
u.username as CustomerName, u.email as email, 
u.phone_number as PhoneNumber,
t.end_time as Date_destination, cou2.name_country AS Country,
c2.name_city as CityDestination,
t.fare*(1-p.promotion_discount) as Total_Price
FROM PickApp.trips as t
JOIN pickapp.users as u ON u.user_id = t.user_id
JOIN pickapp.city as c2 ON c2.city_id = t.end_city_id 
JOIN pickapp.promotions as p ON p.promotion_id = p.promotion_id
JOIN pickapp.paymentmethods as pa ON pa.paymentMethod_id = t.payment_method_id
JOIN pickapp.Country as cou2 on cou2.country_id = c2.country_id
WHERE ride_status = 'Completed';


#Second view Trips info###
CREATE VIEW TripsRideFare AS
SELECT
	t.trip_id as Trip_id,
    tr.ride_name as Type_Ride,
    t.fare AS price_before_promotion,
    p.promotion_discount as PromotionDiscount, 
    t.fare*(1-p.promotion_discount) as Total,	
	pa.payment_name as PaymentMethod
FROM pickapp.Trips as t
JOIN pickapp.PaymentMethods as pa ON t.payment_method_id = pa.paymentmethod_id
JOIN pickapp.Promotions as p ON t.promotions_id = p.promotion_id
JOIN pickapp.drivers as d ON d.driver_id = t.driver_id
JOIN pickapp.vehicles as v ON v.driver_id = d.driver_id
JOIN pickapp.typeofride as tr ON tr.ride_id = v.vehicle_type_id
WHERE t.ride_status = 'Completed';


##Checking view##

SELECT * FROM PickAppCustomers;

SELECT * FROM TripsRideFare;