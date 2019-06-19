Create Table [dbo].[Product]
(
	[ProdID] NVARCHAR (50) Not Null,
	[CatID] INT Not Null,
	[Description] NVARCHAR (100),
	[UnitPrice] Money,
	Constraint PK_Product Primary Key (ProdID),
	Constraint FK_Product_Category Foreign Key (CatID) References Category (CatID)
)