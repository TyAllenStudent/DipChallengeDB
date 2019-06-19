﻿/*
Deployment script for Week16_DBChallenge

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar LoadTestData "true"
:setvar DatabaseName "Week16_DBChallenge"
:setvar DefaultFilePrefix "Week16_DBChallenge"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
/*
The column [dbo].[Customer].[Region] is being dropped, data loss could occur.

The column [dbo].[Customer].[RegionName] on table [dbo].[Customer] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Customer])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping [dbo].[FK_Customer_Region]...';


GO
ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [FK_Customer_Region];


GO
PRINT N'Altering [dbo].[Customer]...';


GO
ALTER TABLE [dbo].[Customer] DROP COLUMN [Region];


GO
ALTER TABLE [dbo].[Customer]
    ADD [RegionName] NVARCHAR (20) NOT NULL;


GO
PRINT N'Creating [dbo].[FK_Customer_Region]...';


GO
ALTER TABLE [dbo].[Customer] WITH NOCHECK
    ADD CONSTRAINT [FK_Customer_Region] FOREIGN KEY ([RegionName]) REFERENCES [dbo].[Region] ([RegionName]);


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF '$(LoadTestData)' = 'true'

BEGIN

DELETE FROM Customer;
DELETE FROM Product;
DELETE FROM [Order];
DELETE FROM Segment;
DELETE FROM Shipping;
DELETE FROM Category;
DELETE FROM Region;

INSERT INTO Category (CatID, CatName) Values
(1,	'Furniture'),
(2,	'Office Supplies'),
(3, 'Technology');

INSERT INTO Segment (SegtID, SegName) Values 
(1,	'Consumer'),
(2,	'Corporate'),
(3,	'Home Office');

INSERT INTO Product (ProdID, CatID, [Description], UnitPrice) Values 
('FUR-BO-10001798',	1,	'Bush Somerset Collection Bookcase', 261.96),
('FUR-CH-10000454',	3,	'Mitel 5320 IP Phone VoIP phone',	731.94),
('OFF-LA-10000240',	2,	'Self-Adhesive Address Labels for Typewriters by Universal',	14.62);

INSERT INTO Customer (CustID, FullName, SegtID, Country, City, [State], PostCode, Region) Values
('CG-12520',	'Claire Gute',	1,	'United States',	'Henderson',	'Oklahoma',	42420,	'Central'),
('DV-13045',	'Darrin Van Huff',	2,	'United States',	'Los Angeles',	'California',	90036,	'West'),
('SO-20335',	'Sean ODonnell',	1,	'United States',	'Fort Lauderdale',	'Florida',	33311,	'South'),
('BH-11710',	'Brosina Hoffman',	3,	'United States',	'Los Angeles',	'California',	90032,	'West');

INSERT INTO [Order] (CustID, ProdID, OrderDate, Quantity, ShipDate, ShipMode) Values
('CG-12520',	'FUR-BO-10001798',	'8/11/2016',	2,	'11/11/2016',	'Second Class'),
('CG-12520',	'FUR-CH-10000454',	'8/11/2016',	3,	'11/11/2016',	'Second Class'),
('CG-12520',	'OFF-LA-10000240',	'12/06/2016',	2,	'16/06/2016',	'Second Class'),
('DV-13045',	'OFF-LA-10000240',	'21/11/2015',	2,	'26/11/2015',	'Second Class'),
('DV-13045',	'OFF-LA-10000240',	'11/10/2014',	1,	'15/10/2014',	'Standard Class'),
('DV-13045',	'FUR-CH-10000454',	'12/11/2016',	9,	'16/11/2016',	'Standard Class'),
('SO-20335',	'OFF-LA-10000240',	'2/09/2016',	5,	'8/09/2016',	'Standard Class'),
('SO-20335',	'FUR-BO-10001798',	'25/08/2017',	2,	'29/08/2017',	'Overnight Express'),
('SO-20335',	'FUR-CH-10000454',	'22/06/2017',	2,	'26/06/2017',	'Standard Class'),
('SO-20335',	'FUR-BO-10001798',	'1/05/2017',	3,	'2/05/2017',	'First Class');
 
INSERT INTO Shipping (ShipMode) Values
('Second Class'),
('Standard Class'),
('First Class'),
('Overnight Express');
	
INSERT INTO Region (Region) Values
('South'),
('Central'),
('West'),
('East'),
('North');

END;	
GO

GO