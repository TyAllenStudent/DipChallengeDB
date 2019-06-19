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

INSERT INTO Region (RegionName) Values
('South'),
('Central'),
('West'),
('East'),
('North');

INSERT INTO Shipping (ShipMode) Values
('Second Class'),
('Standard Class'),
('First Class'),
('Overnight Express');

INSERT INTO Product (ProdID, CatID, [Description], UnitPrice) Values 
('FUR-BO-10001798',	1,	'Bush Somerset Collection Bookcase', 261.96),
('FUR-CH-10000454',	3,	'Mitel 5320 IP Phone VoIP phone',	731.94),
('OFF-LA-10000240',	2,	'Self-Adhesive Address Labels for Typewriters by Universal',	14.62);

INSERT INTO Customer (CustID, FullName, SegtID, Country, City, [State], PostCode, RegionName) Values
('CG-12520',	'Claire Gute',	1,	'United States',	'Henderson',	'Oklahoma',	42420,	'Central'),
('DV-13045',	'Darrin Van Huff',	2,	'United States',	'Los Angeles',	'California',	90036,	'West'),
('SO-20335',	'Sean ODonnell',	1,	'United States',	'Fort Lauderdale',	'Florida',	33311,	'South'),
('BH-11710',	'Brosina Hoffman',	3,	'United States',	'Los Angeles',	'California',	90032,	'West');

INSERT INTO [Order] (CustID, ProdID, OrderDate, Quantity, ShipDate, ShipMode) Values
('CG-12520',	'FUR-BO-10001798',	'11/8/2016',	2,	'11/11/2016',	'Second Class'),
('CG-12520',	'FUR-CH-10000454',	'11/8/2016',	3,	'11/11/2016',	'Second Class'),
('CG-12520',	'OFF-LA-10000240',	'06/12/2016',	2,	'06/16/2016',	'Second Class'),
('DV-13045',	'OFF-LA-10000240',	'11/21/2015',	2,	'11/26/2015',	'Second Class'),
('DV-13045',	'OFF-LA-10000240',	'10/11/2014',	1,	'10/15/2014',	'Standard Class'),
('DV-13045',	'FUR-CH-10000454',	'11/12/2016',	9,	'11/16/2016',	'Standard Class'),
('SO-20335',	'OFF-LA-10000240',	'09/2/2016',	5,	'09/8/2016',	'Standard Class'),
('SO-20335',	'FUR-BO-10001798',	'08/25/2017',	2,	'08/29/2017',	'Overnight Express'),
('SO-20335',	'FUR-CH-10000454',	'06/22/2017',	2,	'06/26/2017',	'Standard Class'),
('SO-20335',	'FUR-BO-10001798',	'05/1/2017',	3,	'05/2/2017',	'First Class');

END;	
GO

GO
PRINT N'Update complete.';


GO
