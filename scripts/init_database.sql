/*

================================================================

Create Database and Schemas

================================================================

Script Purpose

	This script creates a new database named 'Datawarehous' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
	within the database: 'bronze', 'silver', and 'gold'.

WARNING:

	Runnng this script will drop the entire 'Datawarehouse' database if it exists.
	All data in the database will be permanently deleted. Proceed with caution 
	and ensure you have proper backups before running this script.

================================================================

*/
USE MASTER;

GO

-- Drop and recreate the 'Datawarehouse' database 

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Datawarehouse;
	END;
	GO

-- Create the 'Datawarehouse' database

CREATE DATABASE Datawarehouse;
GO

USE Datawarehouse;
GO 

-- Create the schemas

CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO
  
CREATE SCHEMA gold;
GO

