Create Table [dbo].[Customer]
(
	[CustID] NVARCHAR (10) Not Null,
	[FullName] NVARCHAR (100) Not Null,
	[SegtID] int Not Null,
	[Country] NVARCHAR (50) Not Null,
	[City] NVARCHAR (50) Not Null,
	[State] NVARCHAR (50) Not Null,
	[PostCode] int, 
	[Region] NVARCHAR (20) Not Null,
	Constraint PK_Customer Primary Key (CustID),
	Constraint FK_Customer_Segment Foreign Key (SegtID) References Segment (SegtID),
	Constraint FK_Customer_Region Foreign Key (Region) References Region (Region)	
)
