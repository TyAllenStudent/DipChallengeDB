Create Table [dbo].[Category]
(
	[CatID] INT Not Null,
	[CatName] NVARCHAR (50) Not Null,
	Constraint PK_Category Primary Key (CatID),
)