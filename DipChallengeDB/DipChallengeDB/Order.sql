Create Table [dbo].[Order]
(
	[CustID] NVARCHAR (10) Not Null,
	[ProdID] NVARCHAR (50) Not Null,
	[OrderDate] Date Not Null,
	[Quantity] int Not Null,
	[ShipDate] Date,
	[ShipMode] NVARCHAR (50),
	Constraint PK_Order Primary Key (CustID, ProdID, OrderDate),
	Constraint FK_Order_CustID Foreign Key (CustID) References Customer (CustID),
	Constraint FK_Order_ProdID Foreign Key (ProdID) References Product (ProdID),
	Constraint FK_Order_ShipMode Foreign Key (ShipMode) References Shipping (ShipMode)	
)