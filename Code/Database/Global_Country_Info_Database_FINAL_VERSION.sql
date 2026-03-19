-- Create the database
DROP DATABASE IF EXISTS Global_Country_Info;
CREATE DATABASE Global_Country_Info;

-- Use the database
use Global_Country_Info;

-- Create the tables

CREATE TABLE CountryLocation(
Country VARCHAR(25),
Latitude DECIMAL(9,6),
Longitude DECIMAL(9,6),

Constraint pk_country_loc PRIMARY KEY(Country)
);

CREATE TABLE Countries(
Record_ID	INT NOT NULL AUTO_INCREMENT,
Country VARCHAR(25) NOT NULL,
Year YEAR NOT NULL,
ISO_CODE VARCHAR(3)NOT NULL,
yearly_average_temperature 	DECIMAL(10, 8)		NOT NULL,
yearly_average_temperature_uncertainty 	DECIMAL(16, 15)		NOT NULL,
Methane		DECIMAL(7,2), 
Nitrous_oxide 	DECIMAL(7,2),
Total_ghg DECIMAL(7,2),
Total_ghg_excl_lucf	DECIMAL(7,2), 
Trade_co2 	DECIMAL(7,3),
Cement_co2 	DECIMAL(7,3),
Coal_co2 	DECIMAL(7,3),
Flaring_co2 	DECIMAL(7,3),
Gas_co2 	DECIMAL(7,3),
Oil_co2 	DECIMAL(7,3),
Other_industry_co2 	DECIMAL(7,3),
Consumption_co2 	DECIMAL(7,3),
Population 		INT,
GDP 	BIGINT,
Primary_Energy_Consumption DECIMAL(8,3),

Constraint pk_countries PRIMARY KEY(Record_ID, Country, Year),
Constraint fk_countryloc_info FOREIGN KEY(Country) references CountryLocation(Country)
);

CREATE TABLE Grains(
Grains_Record_ID 	INT	 	NOT NULL	AUTO_INCREMENT,
Record_ID	INT	,
Commodity_ID			INT,
Commodity_Description	VARCHAR(25),
Area_Harvested_HA		INT,
Beginning_Stocks_MT		INT,
Ending_Stocks_MT		INT,
Imports_MT		INT,
Exports_MT		INT,
Feed_Dom_Consumption_MT	INT,
FSI_Consumption_MT		INT,
Production_MT		INT,
TY_Imports_MT		INT,
TY_Imports_from_US_MT		INT,
TY_Exports_MT		INT,
Milling_Rate_MT		INT,
Rough_Production_MT	INT,

INDEX(Record_ID),
Constraint pk_grains PRIMARY KEY (Grains_Record_ID),
Constraint fk_grains_weather FOREIGN KEY (Record_ID) references Countries(Record_ID)
);



-- Adding Test Data to test composite primary keys and composite foreign keys
-- ALTER TABLE Grains ADD Constraint fk_grains_countries FOREIGN KEY (Record_ID, Country, Market_Year) references Countries(Record_ID, Country_name, Calendar_Year); 

-- Inserting Test Values, from the datasets.CSVs

-- 1990 United States Test
-- INSERT INTO Countries values (0, 'USA', 'United States', 1990, 9.521583, 0.186167, 767.47, 250.21, 12.22, 15.5, -81.669, 33.484, 1841.986, 41.757, 1033.673, 2138.355, 24.199, 5031.786, 252120309, 9250380000000, 450.321);
-- INSERT INTO Grains values (0, 1, 410000, 'Wheat', 'United States', 1990, 27965000, 14600000, 23627000, 991000, 29106000, 13129000, 24021000, 74292000, 939000, 0, 28500000, NULL, NULL);
-- INSERT INTO Grains values (NULL, 1, 422110, 'Rice, Milled', 'United States', 1990, 1142000, 8660000, 803000, 151000, 2331000, NULL, NULL, 5098000, 164000, 0, 2199000, 7200000, 7081000);

-- 1990 Uruguay Test (same data except Country/ISO_Code)
-- INSERT INTO Countries values (NULL, 'URY', 'Uruguay', 1990, 9.521583, 0.186167, 767.47, 250.21, 12.22, 15.5, -81.669, 33.484, 1841.986, 41.757, 1033.673, 2138.355, 24.199, 5031.786, 252120309, 9250380000000, 450.321);
-- INSERT INTO Grains values (NULL, 2,  410000, 'Wheat', 'Uruguay', 1990, 27965000, 14600000, 23627000, 991000, 29106000, 13129000, 24021000, 74292000, 939000, 0, 28500000, NULL, NULL);
 -- INSERT INTO Grains values (NULL, 2, 422110, 'Rice, Milled', 'Uruguay', 1990, 1142000, 8660000, 803000, 151000, 2331000, NULL, NULL, 5098000, 164000, 0, 2199000, 7200000, 7081000);

-- 1990 United Kingdom Test (same data except Country/ISO_Code)
-- INSERT INTO Countries values (NULL, 'GBR', 'United Kingdom', 1990, 9.521583, 0.186167, 767.47, 250.21, 12.22, 15.5, -81.669, 33.484, 1841.986, 41.757, 1033.673, 2138.355, 24.199, 5031.786, 252120309, 9250380000000, 450.321);
-- INSERT INTO Grains values (NULL, 3,  NULL, 'No Grains', 'United Kingdom', 1990, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
 
-- 1990 United States Test (same data except Country/Year/ISO_Code)
-- INSERT INTO Countries values (NULL, 'USA', 'United States', 1991, 9.521583, 0.186167, 767.47, 250.21, 12.22, 15.5, -81.669, 33.484, 1841.986, 41.757, 1033.673, 2138.355, 24.199, 5031.786, 252120309, 9250380000000, 450.321);
-- INSERT INTO Grains values (NULL , 4, 410000, 'Wheat', 'United States', 1991, 27965000, 14600000, 23627000, 991000, 29106000, 13129000, 24021000, 74292000, 939000, 0, 28500000, NULL, NULL);
-- INSERT INTO Grains values (NULL, 4, 422110, 'Rice, Milled', 'United States', 1991, 1142000, 8660000, 803000, 151000, 2331000, NULL, NULL, 5098000, 164000, 0, 2199000, 7200000, 7081000);

-- 1990 Uruguay Test (same data except Country/Year/ISO_Code)
-- INSERT INTO Countries values (NULL, 'URY', 'Uruguay', 1991, 9.521583, 0.186167, 767.47, 250.21, 12.22, 15.5, -81.669, 33.484, 1841.986, 41.757, 1033.673, 2138.355, 24.199, 5031.786, 252120309, 9250380000000, 450.321);
-- INSERT INTO Grains values (NULL, 5,  410000, 'Wheat', 'Uruguay', 1991, 27965000, 14600000, 23627000, 991000, 29106000, 13129000, 24021000, 74292000, 939000, 0, 28500000, NULL, NULL);
-- INSERT INTO Grains values (NULL, 5, 422110, 'Rice, Milled', 'Uruguay', 1991, 1142000, 8660000, 803000, 151000, 2331000, NULL, NULL, 5098000, 164000, 0, 2199000, 7200000, 7081000);

-- 1990 United Kingdom Test (same data except Country/Year/ISO_Code)
-- INSERT INTO Countries values (NULL, 'GBR', 'United Kingdom', 1991, 9.521583, 0.186167, 767.47, 250.21, 12.22, 15.5, -81.669, 33.484, 1841.986, 41.757, 1033.673, 2138.355, 24.199, 5031.786, 252120309, 9250380000000, 450.321);
-- INSERT INTO Grains values (NULL, 6,  NULL, 'No Grains', 'United Kingdom', 1991, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- SELECT Countries.Record_ID, Countries.ISO_Code, Countries.Country_name, Countries.Calandar_Year, Countries.yearly_average_temperature, Countries.yearly_average_temperature_uncertainty, Countries.Methane, Countries.Record_ID, Countries.Record_ID, Countries.Record_ID,  

-- SELECT * FROM Countries RIGHT JOIN Grains ON Countries.Country_name=Grains.Country;
-- Countries.Commodity_ID=Grains.Commodity_ID, Countries.Calendar_Year=Grains.Market_Year

-- Select * from Countries;
-- Select * from Grains;

-- Real_Final_Integrated_Data.csv
SELECT c.Country, Year, yearly_average_temperature, 
	yearly_average_temperature_uncertainty, Methane, 
    Nitrous_oxide, Total_ghg, Total_ghg_excl_lucf, Trade_co2
    (Cement_co2 + Coal_co2 + Flaring_co2 + Gas_co2 + Oil_co2 + Other_industry_co2) AS Total_co2, 
    Consumption_co2, Population, GDP, Primary_Energy_Consumption, Latitude, Longitude, 
    Commodity_ID, Commodity_Description, Area_Harvested_HA, Beginning_Stocks_MT, Ending_Stocks_MT, 
    Imports_MT, Exports_MT, Feed_Dom_Consumption_MT, FSI_Consumption_MT, Production_MT, 
    TY_Imports_MT, TY_Imports_from_US_MT, 
    TY_Exports_MT, Milling_Rate_MT, Rough_Production_MT 
FROM Countries AS c 
LEFT JOIN countrylocation AS cl ON c.Country = cl.Country 
LEFT JOIN grains AS g ON c.Record_ID = g.Record_ID;

-- SELECT Country, Year, yearly_average_temperature, yearly_average_temperature_uncertainty, Methane, Nitrous_oxide, Total_ghg, Total_ghg_excl_lucf, (Trade_co2 + Cement_co2 + Coal_co2 + Flaring_co2 + Gas_co2 + Oil_co2 + Other_industry_co2 + Consumption_co2) AS Total_co2, Population, GDP, Primary_Energy_Consumption FROM Countries;

-- SELECT Record_ID, yearly_average_temperature, yearly_average_temperature_uncertainty, Methane, Nitrous_oxide, Total_ghg, Total_ghg_excl_lucf, Trade_co2, Cement_co2, Coal_co2, Flaring_co2, Gas_co2, Oil_co2, Other_industry_co2, Consumption_co2, Population, GDP, Primary_Energy_Consumption, Latitude, Longitude FROM Countries AS c LEFT JOIN countrylocation AS cl ON c.Country = cl.Country;


-- SELECT Country, Year, ISO_CODE, yearly_average_temperature, yearly_average_temperature_uncertainty, Methane, Nitrous_oxide, Total_ghg, Total_ghg_excl_lucf, Trade_co2, Cement_co2, Coal_co2, Flaring_co2, Gas_co2, Oil_co2, Other_industry_co2, Consumption_co2, Population, GDP, Primary_Energy_Consumption FROM Countries;