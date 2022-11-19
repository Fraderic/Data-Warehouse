-- Select  dimensionnya mau ambil data

--CUSTOMER

SELECT 
	--CustomerCode, GA USH CODENYA
	CustomerID,
	CustomerName,
	CustomerGender,
	CustomerDOB,
	CustomerAddress,
	CustomerPhone

FROM VanMart..MsCustomer

Select * From VanMartOlap..CustomerDimension

-- Goods Dimension
SELECT	
	GoodsID, --> BUSINESS KEY
	GoodsName,
	GoodsSellingPrice, --> (Historical)
	GoodsBuyingPrice --> (Historical)

FROM VanMart..MsGoods

Select * From VanMartOlap..GoodsDimension


-- Staff Dimension
SELECT	
	StaffID, --> BUSINESS KEY
	StaffName,
	StaffDOB,
	StaffSalary, --> (Historical)
	StaffGender

FROM VanMart..MsStaff

-- Supplier Dimension
SELECT
	SupplierID, --> BUSINESS KEY
	SupplierName,
	SupplierAddress, --> (Changing)
	CityName --(buat joint)

FROM
	VanMart..MsSupplier S JOIN VanMart..MsCity C ON S.CityID = C.CityID


-- BRANCH DIMENSION

SELECT
	--BranchCode, --> PK
	BranchID, --> BUSINESS KEY
	BranchAddress,	--> (Changing)
	CityName --(buat joint)

FROM
	VanMart..MsBranch B JOIN VanMart..MsCity C ON B.CityID = C.CityID




	-- VanMart..MsBranch B JOIN VanMart..MsCity C ON B.CityID = C.CityID


-- BenefitDimension.dtsx
SELECT
	--BenefitsCode -> PK
	BenefitID, --> BUSINESS KEY
	BenefitName,
	BenefitPrice	--> (Historical)

FROM VanMart..MsBenefit


-- =================== TIME DIMENSION =====================

IF EXISTS(
	SELECT*
	FROM VanMartOlap..FilterTimeStamp
	WHERE TableName = 'TimeDimension'
)

BEGIN
	SELECT 
	
	[Date] = x.DATE,
	[Month] = MONTH(x.DATE),
	[Quarter] = DATEPART(QUARTER,x.DATE),
	[Annual] = YEAR(x.DATE)

	FROM (

	SELECT
		SubscriptionStartDate AS [DATE]
	FROM VanMart..TrSubscriptionHeader
	UNION
	SELECT
		SalesDate AS [DATE]
	FROM VanMart..TrSalesHeader
	UNION
	SELECT
		ReturnDate AS [DATE]
	FROM VanMart..TrReturnHeader
	UNION
	SELECT
		PurchaseDate AS [DATE]
	FROM VanMart..TrPurchaseHeader


	) AS x

	WHERE [Date]>(
		SELECT LastETL
		FROM VanMartOlap..FilterTimeStamp
		WHERE TableName = 'TimeDimension'
	
	)

END

ELSE

BEGIN
-- COPAS BEGIN END

SELECT 
	
	[Date] = x.DATE,
	[Month] = MONTH(x.DATE),
	[Quarter] = DATEPART(QUARTER,x.DATE),
	[Annual] = YEAR(x.DATE)

	FROM (

	SELECT
		SubscriptionStartDate AS [DATE]
	FROM VanMart..TrSubscriptionHeader
	UNION
	SELECT
		SalesDate AS [DATE]
	FROM VanMart..TrSalesHeader
	UNION
	SELECT
		ReturnDate AS [DATE]
	FROM VanMart..TrReturnHeader
	UNION
	SELECT
		PurchaseDate AS [DATE]
	FROM VanMart..TrPurchaseHeader


	) AS x
END

-- QUERRY LAST ETL

IF EXISTS(
	
	SELECT*
	FROM VanMartOlap..FilterTimeStamp
	WHERE TableName = 'TimeDimension'

)
BEGIN 
	
	UPDATE VanMartOlap..FilterTimeStamp
	SET LastETL = GETDATE()
	WHERE TableName = 'TimeDimension'
	
END
ELSE
BEGIN
	INSERT INTO VanMartOlap..FilterTimeStamp VALUES
	('TimeDimension', GETDATE())
	
END


-- TIME DIMENSION --

IF EXISTS (
	SELECT*
	FROM VanMartOlap..FilterTimeStamp
	WHERE TableName = 'TimeDimension'
)

BEGIN
	SELECT 
	
	[Date] = x.DATE,
	[Month] = MONTH(x.DATE),
	[Quarter] = DATEPART(QUARTER, x.DATE),
	[Annual] = YEAR(x.DATE)


FROM(

SELECT
	SubscriptionStartDate AS [DATE]
	FROM VanMart..TrSubscriptionHeader
	UNION

	SELECT
	SalesDate AS [DATE]
	FROM VanMart..TrSalesHeader
	UNION

	SELECT
	ReturnDate AS [DATE]
	FROM VanMart..TrReturnHeader
	UNION
	SELECT

	PurchaseDate AS [DATE]
	FROM VanMart..TrPurchaseHeader
	) AS x

	WHERE [DATE]>(
		SELECT LastETL
		FROM VanMartOlap..FilterTimeStamp
		WHERE TableName = 'TimeDimension'
	
	)

END

ELSE
BEGIN

	SELECT 
	
	[Date] = x.DATE,
	[Month] = MONTH(x.DATE),
	[Quarter] = DATEPART(QUARTER, x.DATE),
	[Annual] = YEAR(x.DATE)


FROM(

SELECT
	SubscriptionStartDate AS [DATE]
	FROM VanMart..TrSubscriptionHeader
	UNION

	SELECT
	SalesDate AS [DATE]
	FROM VanMart..TrSalesHeader
	UNION

	SELECT
	ReturnDate AS [DATE]
	FROM VanMart..TrReturnHeader
	UNION
	SELECT

	PurchaseDate AS [DATE]
	FROM VanMart..TrPurchaseHeader
	) AS x

END



-- last etl querry

IF EXISTS (
	SELECT LastETL
	FROM VanMartOlap..FilterTimeStamp
	WHERE TableName = 'TimeDimension'
)


BEGIN

	UPDATE VanMartOlap..FilterTimeStamp 
	SET LastETL= GETDATE()
	WHERE TableName = 'TimeDimension'

END

ELSE
BEGIN 
	INSERT INTO VanMartOlap..FilterTimeStamp VALUES
	('TimeDimension',GETDATE())
END

-- TIME DIMENSION --

IF EXISTS (
	
	SELECT*
	FROM VanMartOlap..FilterTimeStamp
	WHERE TableName = 'TimeDimension'

)

BEGIN

	SELECT 
	
		[Date] = x.Date,
		[Month] = MONTH(x.Date),
		[Quarter] = DATEPART(QUARTER,x.Date),
		[Annual] = YEAR(x.Date)
	FROM(

	SELECT
	SubscriptionStartDate AS [Date]
	FROM VanMart..TrSubscriptionHeader
	UNION

	SELECT
	SalesDate AS [Date]
	FROM VanMart..TrSalesHeader
	UNION

	SELECT
	ReturnDate AS [Date]
	FROM VanMart..TrReturnHeader
	UNION
	SELECT

	PurchaseDate AS [Date]
	FROM VanMart..TrPurchaseHeader
	) AS x

	WHERE [Date]>(
	
	SELECT LastETL
	FROM VanMartOlap..FilterTimeStamp
	WHERE TableName = 'TimeDimension'
	
	)

END

ELSE

BEGIN 
	
		SELECT 
	
		[Date] = x.Date,
		[Month] = MONTH(x.Date),
		[Quarter] = DATEPART(QUARTER,x.Date),
		[Annual] = YEAR(x.Date)
	FROM(

	SELECT
	SubscriptionStartDate AS [Date]
	FROM VanMart..TrSubscriptionHeader
	UNION

	SELECT
	SalesDate AS [Date]
	FROM VanMart..TrSalesHeader
	UNION

	SELECT
	ReturnDate AS [Date]
	FROM VanMart..TrReturnHeader
	UNION
	SELECT

	PurchaseDate AS [Date]
	FROM VanMart..TrPurchaseHeader
	) AS x

	WHERE [Date]>(
	
	SELECT LastETL
	FROM VanMartOlap..FilterTimeStamp
	WHERE TableName = 'TimeDimension'
	
	)


END


	