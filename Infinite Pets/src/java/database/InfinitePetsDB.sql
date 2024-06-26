
DROP SCHEMA IF EXISTS `infinitepetsdb` ;

CREATE SCHEMA IF NOT EXISTS `infinitepetsdb` DEFAULT CHARACTER SET utf8 ;
USE `infinitepetsdb` ;

-- ServiceType
-- To be used in Service and employee tables.
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.serviceType (
    `ServiceTypeID` INT NOT NULL auto_increment,
    `ServiceType` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`ServiceTypeID`)
)
ENGINE=InnoDB;

-- Services
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`service` (
    `ServiceID` INT NOT NULL AUTO_INCREMENT,
    `ServiceTypeID` INT NOT NULL,
    `ServiceName` VARCHAR(40) NOT NULL,
    `ServiceDescription` TEXT CHARACTER SET utf16 COLLATE utf16_bin, -- 64 KB blob of text storage. will hold something like 2000 words,
    `BasePrice` DECIMAL(6,2) NOT NULL, -- can hold up to 9999.99, not that I expect anything to be more than 300, but youknow.
    `Active` BIT NOT NULL, -- currently available
    PRIMARY KEY (`ServiceID`),
    CONSTRAINT `fk_service_type`
        FOREIGN KEY (ServiceTypeID)
        REFERENCES infinitepetsdb.serviceType (ServiceTypeID)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- Promotion
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`promotion` (
    `PromoID` INT NOT NULL AUTO_INCREMENT,
    `PromotionName` VARCHAR (50) NOT NULL,
    `PromoDescription` VARCHAR (200) NOT NULL,
    `StartDate` Date NOT NULL,
    `EndDate` Date NOT NULL,
    `Active` Boolean NOT NULL,
    PRIMARY KEY (`PromoID`)
)
ENGINE = InnoDB;

-- Discount
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`discount` (
    `DiscountID` INT NOT NULL AUTO_INCREMENT,
    `ServiceID` INT NOT NULL,
    `PromoID` INT NOT NULL,
    `Discount` DECIMAL(6,2) NOT NULL,
    `DiscountType` CHAR(1) NOT NULL,
    PRIMARY KEY (`DiscountID`),
    INDEX `fk_service_idx` (`ServiceID` ASC),
    CONSTRAINT `fk_service_id`
            FOREIGN KEY (`ServiceID`)
            REFERENCES `infinitepetsdb`.`service` (`ServiceID`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    INDEX `fk_promo_idx` (`PromoID` ASC),
    CONSTRAINT `fk_promo_id`
            FOREIGN KEY (`PromoID`)
            REFERENCES `infinitepetsdb`.`promotion` (`PromoID`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- Location
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`location` (
    `LocationID` INT NOT NULL AUTO_INCREMENT,
    `LocationType` CHAR(1) NOT NULL,
    `PostalCode` VARCHAR(7) NOT NULL,
    `Address` VARCHAR(30) NOT NULL,
    `City` VARCHAR(30) NOT NULL,
    `Country` VARCHAR(30) NOT NULL,
    `Province` VARCHAR(30) NOT NULL,
    `Area` VARCHAR(2) NOT NULL,
    CONSTRAINT `chk_area`
            CHECK (`Area` IN ('N','S', 'W', 'E', 'NW', 'NE', 'SW', 'SE')),
    PRIMARY KEY (`LocationID`)
    )
ENGINE = InnoDB;

-- Account
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`account` (
    `UserId` INT NOT NULL AUTO_INCREMENT,
	`PasswordHash` VARCHAR(64) NOT NULL,
	`PasswordSalt` VARCHAR(32) NOT NULL,
    `Email` VARCHAR(100) NOT NULL,
    `FirstName` VARCHAR(50) NOT NULL,
    `LastName` VARCHAR(50) NOT NULL,
    `Address` INT NOT NULL,
    `IsEmployee` BIT NOT NULL,
    `IsConfirmed` BIT NOT NULL,
	`PasswordResetCode` VARCHAR(36),
    `DeleteAccountCode` VARCHAR(36),
	`PasswordResetActive` BIT DEFAULT 0,
    PRIMARY KEY (`UserID`),
    INDEX `fk_address_idx` (`Address` ASC),
    CONSTRAINT `fk_address_id`
            FOREIGN KEY (`Address`)
            REFERENCES `infinitepetsdb`.`location` (`LocationID`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- Employee
-- this is just temporary, it's not complete.
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`employee` (
    `EmployeeID` INT NOT NULL AUTO_INCREMENT,
    `UserID` INT NOT NULL,
    `IsAdmin` BIT NOT NULL,
    `OnVacation` BIT NOT NULL,
    `Active` BIT NOT NULL,
    PRIMARY KEY (`EmployeeID`),
	INDEX `fk_employees_accounts_idx` (`UserId` ASC),
    CONSTRAINT `fk_employees_accounts`
        FOREIGN KEY (`UserId`)
    REFERENCES `infinitepetsdb`.`account` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- Employee Service Preferences
-- This table will be referring (FK) to ServiceType and Employee
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`empServicePreference` (
    `EmpServicePreferenceID` INT NOT NULL AUTO_INCREMENT,
    `EmployeeID` INT NOT NULL,
    `ServiceTypeID` INT NOT NULL,
    PRIMARY KEY (EmpServicePreferenceID),
    INDEX `fk_employee_idx` (`EmployeeID` ASC),
    CONSTRAINT `fk_employee_id`
        FOREIGN KEY (EmployeeID)
    REFERENCES infinitepetsdb.employee (EmployeeID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
    INDEX `fk_serviceType_idx` (`ServiceTypeID` ASC),
    CONSTRAINT `fk_serviceType_id`
        FOREIGN KEY (ServiceTypeID)
    REFERENCES infinitepetsdb.serviceType (ServiceTypeID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
    CONSTRAINT `UC_EmployeeID_SericeID`
        UNIQUE(EmployeeID, ServiceTypeID)
    )
ENGINE = InnoDB;

-- Employee Qualifications
-- This table will be referring (FK) to ServiceType and Employee
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`empQualification` (
    `EmpQualificationID` INT NOT NULL AUTO_INCREMENT,
    `EmployeeID` INT NOT NULL,
    `ServiceID` INT NOT NULL,
    PRIMARY KEY (EmpQualificationID),
    INDEX `fk_employee_qualification_idx` (`EmployeeID` ASC),
    CONSTRAINT `fk_employeeid`
        FOREIGN KEY (EmployeeID)
        REFERENCES infinitepetsdb.employee (EmployeeID)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX `fk_qualification_service_idx` (`ServiceID` ASC),
    CONSTRAINT `fk_qualfication_service`
        FOREIGN KEY (ServiceID)
        REFERENCES infinitepetsdb.service (ServiceID)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- Animal Type Table
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`animal_type` (
    `animal_Type_ID` INT NOT NULL AUTO_INCREMENT,
    `animal_Type` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`animal_Type_ID`)
)
ENGINE = InnoDB;

-- Breed 
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`breed` (
    breed_id INT NOT NULL AUTO_INCREMENT,
    `animal_type_id` INT NOT NULL,
    breed_name VARCHAR(50),
    PRIMARY KEY (breed_id, animal_type_id),
    CONSTRAINT fk_breed_animal_type
        FOREIGN KEY (animal_type_id)
        REFERENCES infinitepetsdb.animal_type (animal_type_id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)
ENGINE = innoDB;

-- Pet
-- Preferred Vet contains 60 chars to account for full name.
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`pet` (
    `PetID` INT NOT NULL AUTO_INCREMENT,
    `Sex` CHAR(1) NOT NULL,
    `Species` VARCHAR(20) NOT NULL,
    `Breed` VARCHAR(60) NOT NULL,
    `PetName` VARCHAR(30) NOT NULL,
    `Owner` INT NOT NULL,
    `Birthday` DATE NOT NULL,
    `PreferredVet` VARCHAR(60),
    `MedicalInfo` VARCHAR(120),
    `ImagePath` VARCHAR(120),
    PRIMARY KEY (`PetID`),
    INDEX `fk_pets_accounts_idx` (`Owner` ASC),
    CONSTRAINT `fk_pets_accounts`
            FOREIGN KEY (`Owner`)
            REFERENCES `infinitepetsdb`.`account` (`UserId`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `chk_pets_sex`
            CHECK (`Sex` IN ('M','F','N','S'))
)
ENGINE = InnoDB;

-- GalleryImage
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`gallery` (
	`ImageID` INT NOT NULL AUTO_INCREMENT,
        `ImageSubtitle` VARCHAR(80),
	`ImagePath` VARCHAR(120),
	`Show` BIT NOT NULL,
	`Featured` BIT NOT NULL,
	PRIMARY KEY (`ImageID`)
)
ENGINE = InnoDB;


-- Appointment
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`appointment` (
	`AppointmentID` INT NOT NULL AUTO_INCREMENT,
	`ClientID` INT NOT NULL,
	`AppointmentDate` DATE NOT NULL,
	`EndDate` DATE DEFAULT NULL, -- used for range
	`AppointmentTime` TIME DEFAULT NULL,
	`Confirmed` BOOLEAN NOT NULL,
	`EmployeeID` INT DEFAULT NULL,
	`Paid` BOOLEAN NOT NULL,
	`Active` BOOLEAN NOT NULL,
	PRIMARY KEY (`AppointmentID`),
	INDEX `fk_appointment_client_idx` (`ClientID` ASC),
    CONSTRAINT `fk_appointment_client`
            FOREIGN KEY (`ClientID`)
            REFERENCES `infinitepetsdb`.`account` (`UserId`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
	INDEX `fk_appointment_employee_idx` (`EmployeeID` ASC),
    CONSTRAINT `fk_appointment_employee`
            FOREIGN KEY (`EmployeeID`)
            REFERENCES `infinitepetsdb`.`employee` (`EmployeeID`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- AppointmentService
-- Refers to Appointment table 
-- 
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`appointmentService` (
    `AppServID` INT NOT NULL AUTO_INCREMENT,
    `AppointmentID` INT NOT NULL,
    `ServiceID` INT NOT NULL,
    `PetID` INT NOT NULL,
    PRIMARY KEY (`AppServID`),
    INDEX `fk_appointmentservice_appointment_idx` (`AppointmentID` ASC),
    CONSTRAINT `fk_appointmentservice_appointment`
        FOREIGN KEY (`AppointmentID`)
        REFERENCES `infinitepetsdb`.`appointment` (`AppointmentID`)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX `fk_appointmentservice_service_idx` (`ServiceID` ASC),
    CONSTRAINT `fk_appointmentservice_service`
        FOREIGN KEY (`ServiceID`)
        REFERENCES `infinitepetsdb`.`service` (`ServiceID`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    INDEX `fk_appointmentservice_pet_idx` (`PetID` ASC),
    CONSTRAINT `fk_appointmentservice_pet`
        FOREIGN KEY (`PetID`)
        REFERENCES `infinitepetsdb`.`pet` (`PetID`)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- Content Management
CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`management` (
    `ItemID` INT NOT NULL AUTO_INCREMENT,
    `ItemName` VARCHAR(40),
    `ItemDescription` VARCHAR(100),
    `ItemLink` VARCHAR(200),
    `ItemPrice` DECIMAL(6,2),
    PRIMARY KEY (`ItemID`)
)
ENGINE = InnoDB;


-- Schedule
	-- For the staff
	-- COmposite PK using Schedule ID and EmployeeID
    CREATE TABLE IF NOT EXISTS `infinitepetsdb`.`schedule` (
        `ScheduleID` INT NOT NULL AUTO_INCREMENT,
        `EmployeeID` INT NOT NULL,
        `startTime` DATETIME NOT NULL,
        `endTime` DATETIME NOT NULL,
        INDEX `fk_schedule_employee_employeeIdx` (`EmployeeID` ASC),
        CONSTRAINT `fk_schedule_employee_employeeID`
			FOREIGN KEY (`EmployeeID`)
            REFERENCES `infinitepetsdb`.`employee` (`EmployeeID`)
            ON DELETE NO ACTION,
        PRIMARY KEY (`ScheduleID`, `EmployeeID`)
    )
    ENGINE = InnoDB;


-- Inserts 
-- Inserts into location
INSERT INTO `location` (`LocationType`, `PostalCode`, `Address`, `City`, `Country`, `Province`, `Area`)
    VALUES
        ('E','A1A 1A1', '1 Center Street', 'Calgary', 'Canada', 'Alberta', 'N'),
        ('E','A2A 2A2', '2 Center Street', 'Calgary', 'Canada', 'Alberta', 'E'),
        ('R','A3A 3A3', '3 Center Street', 'Calgary', 'Canada', 'Alberta', 's'),
        ('R','A4A 4A4', '4 Center Street', 'Calgary', 'Canada', 'Alberta', 'W'),
        ('R','A5A 454', '5 Center Street', 'Calgary', 'Canada', 'Alberta', 'NW');


-- Insert into accounts
INSERT INTO `account` (`PasswordHash`,`PasswordSalt`, `Email`, `FirstName`, `LastName`, `Address`, `IsEmployee`,`IsConfirmed`) -- all passwords are password
    VALUES 
        ('F9A24809961A6191D77C6835A7672B7657B405A9399D146D6C3F4AA10A5D0367','-dEt#9&DStu!n}&N)$Q1&wf2~fFGh?Qr','admin@gmail.com','Admin','Admin', 1, 1, 1),
        ('8A3D18812F48173DBB7EC4027C675D5A7FDA1545B64D1A4FE7969C5EF0DF486C','N2+DoX6vp$kPf/tQ1}_zh*;WE`;QID5x','employee@gmail.com','employee','employee', 2, 1, 1),
        ('8DCC49B77BA19EA674DD910F630B4D0A91EFB335789475160F38F1225981D210','[Y+S^?N2[?gf?.>u.[#;XIQEc^i]6F{^','anne@gmail.com','Anne','Annerson', 3, 0, 1);

-- Insert Service Types
INSERT INTO `serviceType` (`ServiceType`) 
    VALUES
        ('Overnight'),
        ('Dog Walk'),
        ('Grooming'),
        ('Medical');

--Insert Services
INSERT INTO `service` (`ServiceTypeID`, `ServiceName`, `ServiceDescription`, `BasePrice` , `Active`)
    VALUES
        (1, 'Dog Overnight Stay', 'One overnight stay for a dog', 75.00, 1),
        (1, 'Cat Overnight Stay', 'One overnight stay for a Cat', 60.00, 1),
        (2, 'One Hour for One Dog', 'One hour private dog walk for one dog (On Leash)', 35.00, 1),
        (2, 'One Hour for Two Dogs', 'One hour private dog walk for two dogs (On Leash)', 45.00, 1),
        (2, 'Half Hour for One Dog', 'Half hour private dog walk for one dog (On Leash)', 25.00, 1),
        (2, 'Half Hour for Two Dogs', 'Half hour private dog walk for two dogs (On Leash)', 30.00, 1),
        (2, 'Group Walk', 'One hour dog walk for one dog (Off Leash)', 35.00, 1),
        (3, 'Cat Nail Trim', 'Cat nail trim', 20.00, 1),
        (3, 'Dog Nail Trim', 'Dog nail trim', 30.00, 1),
        (3, 'Transport and Bath', 'Includes transport to off-site bathing facility, shampoo, blow dry and brush out', 35.00, 1),
        (4, 'Insulin Injection', 'Personal insulin injection for their pet $10 per day', 10.00, 1),
        (4, 'Medication Administration', 'Personal medical administration needed for their pet', 7.00, 1),
        (4, 'Sub Que Fluid Administration', 'Personal sub que injection for needed pet', 15.00, 1);


--         ('password','asdf+admin@gmail.com','Admin','Admin', 1, 1, 1),
--         ('password','asdf+staff@gmail.com','employee','employee', 2, 1, 1),
--         ('password','cprg352+anne@gmail.com','Anne','Annerson', 3, 0, 1),
--         ('password','asdf+client@gmail.com', 'BCCRS', 'Test', 5, 0, 1),
--         ('password','cprg352+barb@gmail.com','Barb','Barber', 4, 0, 1);


-- insert into employee tables
   -- `UserID` INT NOT NULL,
    -- `IsAdmin` BIT NOT NULL,
   -- `OnVacation` BIT NOT NULL,
    -- `Active` BIT NOT NULL,
INSERT INTO `employee` (`UserID`, `IsAdmin`, `OnVacation`, `Active`)
	VALUES (2, 0, 0, 1),
                (1, 1, 0, 1);


-- Insert into schedule for testing
-- datetime format YYYY-MM-DD HH:MM:SS
INSERT `Schedule` (`EmployeeID`, `startTime`, `endTime`)
	VALUES 
            (1, '2021-03-21 10:00:00', '2021-03-21 17:00:00'),
            (1, '2021-03-22 12:00:00', '2021-03-21 17:00:00');


-- insert into animal_type
INSERT INTO animal_Type (animal_Type)
    VALUES 
        ('Dog'),
        ('Cat'),
        ('Bird');

-- -- Insert into discounts for promotions
--     `ServiceID` INT NOT NULL,
--     `PromoID` INT NOT NULL,
--     `Discount` DECIMAL(6,2) NOT NULL,
--     `DiscountType` CHAR(1) NOT NULL,
-- INSERT INTO discount(ServiceID, 
		
-- Insert all of the dog breeds
SELECT `animal_Type_ID`
	INTO @dog
	FROM `animal_Type`
	WHERE `animal_Type` = 'Dog';
	
INSERT INTO breed (animal_type_id, breed_name)
    VALUES (@dog, 'Akita'),
        (@dog, 'Alaskan Malamute'),
        (@dog, 'American Bulldog'),
        (@dog, 'American Bully (Standard)'),
        (@dog, 'American Eskimo Dog (Miniature)'),
        (@dog, 'American Eskimo Dog (Standard)'),
        (@dog, 'Am. Staffordshire Terrier'),
        (@dog, 'American Pit Bull Terrier'),
        (@dog, 'Australian Cattle Dog (Heeler)'),
        (@dog, 'Australian Kelpie'),
        (@dog, 'Australian Shepherd'),
        (@dog, 'Austrialian Terrier'),
        (@dog, 'Barbet'),
        (@dog, 'Basenji'),
        (@dog, 'Basset Hound'),
        (@dog, 'Beagle'),
        (@dog, 'Beauceron'),
        (@dog, 'Bedlington Terrier'),
        (@dog, 'Belgian Malinois'),
        (@dog, 'Belgian Tervuren'),
        (@dog, 'Bernese Mountain Dog'),
        (@dog, 'Bichon Frise'),
        (@dog, 'Black and Tan Coonhound'),
        (@dog, 'Bloodhound'),
        (@dog, 'Bluetick Coonhound'),
        (@dog, 'Boerboel'),
        (@dog, 'Border Collie'),
        (@dog, 'Border Terrier'),
        (@dog, 'Boston Terrier'),
        (@dog, 'Bouvier des Flandres'),
        (@dog, 'Boxer'),
        (@dog, 'Boykin Spaniel'),
        (@dog, 'Bracco Italiano'),
        (@dog, 'Briard'),
        (@dog, 'Brittany'),
        (@dog, 'Bull Terrier (Standard)'),
        (@dog, 'Bull Terrier (Miniature)'),
        (@dog, 'Bulldog'),
        (@dog, 'Bullmastiff'),
        (@dog, 'Cairn Terrier'),
        (@dog, 'Cane Corso'),
        (@dog, 'Cardigan Welsh Corgi'),
        (@dog, 'Catahoula Leopard Dog'),
        (@dog, 'Caucasian Shepherd (Ovcharka)'),
        (@dog, 'Cavalier King Charles Spaniel'),
        (@dog, 'Chesapeake Bay Retriever'),
        (@dog, 'Chihuahua (Long hair)'),
        (@dog, 'Chihuahua (Smooth)'),
        (@dog, 'Chinese Crested'),
        (@dog, 'Chinese Shar-Pei'),
        (@dog, 'Chinook'),
        (@dog, 'Chow Chow'),
        (@dog, 'Clumber Spaniel'),
        (@dog, 'Cocker Spaniel (American)'),
        (@dog, 'Cocker Spaniel (English)'),
        (@dog, 'Collie (Smooth)'),
        (@dog, 'Collie (Rough)'),
        (@dog, 'Coton De Tulear'),
        (@dog, 'Dachshund (smooth)'),
        (@dog, 'Dachshund (wire/long haired)'),
        (@dog, 'Dalmatian'),
        (@dog, 'Doberman Pinscher'),
        (@dog, 'Dogo Argentino'),
        (@dog, 'Dutch Shepherd'),
        (@dog, 'English Setter'),
        (@dog, 'English Shepherd'),
        (@dog, 'English Springer Spaniel'),
        (@dog, 'English Toy Spaniel'),
        (@dog, 'English Toy Terrier'),
        (@dog, 'Eurasier'),
        (@dog, 'Field Spaniel'),
        (@dog, 'Finnish Lapphund'),
        (@dog, 'Finnish Spitz'),
        (@dog, 'Flat Coat Retriever'),
        (@dog, 'French Bulldog'),
        (@dog, 'German Pinscher'),
        (@dog, 'German Shepherd Dog'),
        (@dog, 'German Shorthaired Pointer'),
        (@dog, 'Giant Schnauzer'),
        (@dog, 'Glen of Imaal Terrier'),
        (@dog, 'Golden Retriever'),
        (@dog, 'Gordon Setter'),
        (@dog, 'Great Dane'),
        (@dog, 'Great Pyrenees'),
        (@dog, 'Greyhound'),
        (@dog, 'Harrier'),
        (@dog, 'Havanese'),
        (@dog, 'Irish Setter'),
        (@dog, 'Irish Terrier'),
        (@dog, 'Irish Wolfhound'),
        (@dog, 'Italian Greyhound'),
        (@dog, 'Japanese Chin'),
        (@dog, 'Japanese Spitz'),
        (@dog, 'Keeshond'),
        (@dog, 'Komondor'),
        (@dog, 'Kooikerhondje'),
        (@dog, 'Kuvasz'),
        (@dog, 'Labrador Retriever'),
        (@dog, 'Lagotto Romagnolo'),
        (@dog, 'Lancashire Heeler'),
        (@dog, 'Leonberger'),
        (@dog, 'Lhasa Apso'),
        (@dog, 'Maltese'),
        (@dog, 'Miniature American Shepherd'),
        (@dog, 'Miniature Pinscher'),
        (@dog, 'Miniature Schnauzer'),
        (@dog, 'Newfoundland'),
        (@dog, 'Norfolk Terrier'),
        (@dog, 'Norwich Terrier'),
        (@dog, 'Nova Scotia Duck Tolling Retriever'),
        (@dog, 'Olde English Bulldogge'),
        (@dog, 'Old English Sheepdog'),
        (@dog, 'Papillon'),
        (@dog, 'Parson Russell Terrier'),
        (@dog, 'Patterdale Terrier (Smooth or Broken)'),
        (@dog, 'Patterdale Terrier (Rough)'),
        (@dog, 'Pekingese'),
        (@dog, 'Pembroke Welsh Corgi'),
        (@dog, 'Pharaoh Hound'),
        (@dog, 'Plott'),
        (@dog, 'Pointer (English)'),
        (@dog, 'Pomeranian'),
        (@dog, 'Poodle (Miniature)'),
        (@dog, 'Poodle (Standard)'),
        (@dog, 'Poodle (Toy)'),
        (@dog, 'Portugese Water Dog'),
        (@dog, 'Presa Canario'),
        (@dog, 'Pug'),
        (@dog, 'Puli'),
        (@dog, 'Pumi'),
        (@dog, 'Rat Terrier'),
        (@dog, 'Redbone Coonhound'),
        (@dog, 'Rhodesian Ridgeback'),
        (@dog, 'Rottweiler'),
        (@dog, 'Russian Toy'),
        (@dog, 'Saluki'),
        (@dog, 'Samoyed'),
        (@dog, 'Schipperke'),
        (@dog, 'Scottish Deerhound'),
        (@dog, 'Scottish Terrier'),
        (@dog, 'Shetland Sheepdog (Sheltie)'),
        (@dog, 'Shiba Inu'),
        (@dog, 'Shih Tzu'),
        (@dog, 'Shiloh Shepherd'),
        (@dog, 'Siberian Husky'),
        (@dog, 'Silky Terrier'),
        (@dog, 'Smooth Fox Terrier'),
        (@dog, 'Soft Coated Wheaten Terrier'),
        (@dog, 'Spanish Water Dog'),
        (@dog, 'Spinone Italiano'),
        (@dog, 'St. Bernard'),
        (@dog, 'Staffordshire Bull Terrier'),
        (@dog, 'Standard Schnauzer'),
        (@dog, 'Swedish Vallhund'),
        (@dog, 'Thai Ridgeback'),
        (@dog, 'Tibetan Mastiff'),
        (@dog, 'Tibetan Terrier'),
        (@dog, 'Toy Fox Terrier'),
        (@dog, 'Treeing Walker Coonhound'),
        (@dog, 'Vizsla'),
        (@dog, 'Weimaraner'),
        (@dog, 'Welsh Springer Spaniel'),
        (@dog, 'West Highland White Terrier'),
        (@dog, 'Whippet'),
        (@dog, 'White Shepherd'),
        (@dog, 'Wire Fox Terrier'),
        (@dog, 'Wirehaired Pointing Griffon'),
        (@dog, 'Xoloitzcuintli'),
        (@dog, 'Yorkshire Terrier');

-- Insert "all" of the cat breeds
SELECT `animal_Type_ID`
    INTO @cat
    FROM `animal_Type`
    WHERE `animal_Type` = 'Cat';
    
INSERT INTO breed (animal_type_id, breed_name)
    VALUES (@cat, 'Long Hair'),
        (@cat, 'Short Hair'),
        (@cat, 'Hairless');


-- Insert pets
--     `Sex` CHAR(1) NOT NULL,
--     `Species` VARCHAR(20) NOT NULL,
--     `Breed` VARCHAR(60) NOT NULL,
--     `PetName` VARCHAR(30) NOT NULL,
--     `Owner` INT NOT NULL,
--     `Birthday` DATE NOT NULL,
--     `PreferredVet` VARCHAR(60),
--     `MedicalInfo` VARCHAR(120),
--     `ImagePath` VARCHAR(120),
INSERT INTO pet(Sex, Species, Breed, PetName, Owner, Birthday)
    VALUES
        ('M', 'Dog', 'Labrador Retriever', 'EIleen', 3, '2015-11-15'),
        ('M', 'Dog', 'Golden Retriever', 'Buddy', 3, '2011-10-15');

-- Insert ServiceType (jsut two)
-- INSERT INTO ServiceType(ServiceType)
--     VALUES
--         ('Dog Grooming'),
--         ('Cat Grooming');

-- -- insert into services
--  `ServiceTypeID` INT NOT NULL,
--     `ServiceName` VARCHAR(40) NOT NULL,
--     `ServiceDescription` TEXT CHARACTER SET utf16 COLLATE utf16_bin, -- 64 KB blob of text storage. will hold something like 2000 words,
--     `BasePrice` DECIMAL(6,2) NOT NULL, -- can hold up to 9999.99, not that I expect anything to be more than 300, but youknow.
--     `Active` BIT NOT NULL, -- currently available
--     `SpecifyPet` BIT NOT NULL, -- if the client needs to specify what pet will have the service, things like pet/house sitting, don't I'd imagine.
--     `DateRange` BIT NOT NULL, -- if it's a long term thing, again, the sitting

-- INSERT INTO service(ServiceTypeID, ServiceName, ServiceDescription, BasePrice, Active)
--     VALUES
--         (1, 'Dog Nail Clipping', 'The dog''s nails will be clipped to an appropriate length', 20.00, 1),
--         (1, 'Dog Bath & Brushing', 'The dog would be bathed and then brushed afterwards', 22.00, 1),
--         (2, 'Cat Nail Clipping', 'The cat''s nails would be clipped to appropriate length', 25.00, 1),
--         (2, 'Cat Bath', 'The cat woild be bathed', 30.00, 1);

-- Insert Appointments
-- -- Remember this is appointment holds only general info, not Pet or services.
-- 
-- `ClientID` INT NOT NULL,
-- 	`AppointmentDate` DATE NOT NULL,
-- 	`Confirmed` BOOLEAN NOT NULL,
-- 	`EmployeeID` INT DEFAULT NULL,
-- 	`Paid` BOOLEAN NOT NULL,
-- 	`Active` BOOLEAN NOT NULL,

INSERT INTO appointment(ClientID, AppointmentDate, Confirmed, AppointmentTime, EmployeeID, Paid, Active)
    VALUES
        (3, '2021-04-14', false, '09:00:00', 1, false, false),
        (3, '2021-05-14', false, '12:00:00', 1, false, false);

-- Finally, insert AppointmentServices
-- `AppointmentID` INT NOT NULL,
--     `ServiceID` INT NOT NULL,
--     `PetID` INT NOT NULL,
INSERT INTO appointmentService(AppointmentID, ServiceID, PetID)
    VALUES
        (1, 1, 1),
        (1, 1, 2),
        (2, 3, 2); 


-- insert EmpQUalification
--     `EmployeeID` INT NOT NULL,
--     `ServiceTypeID` INT NOT NULL,

-- Employee prefers to work with dog grooming.
INSERT INTO EmpServicePreference(EmployeeID, ServiceTypeID)
    VALUES(1, 1);


-- Employee prefers to work with dog grooming.
INSERT INTO empQualification(EmployeeID, ServiceID)
    VALUES
        (2, 1),
        (2, 2),
        (2, 3);