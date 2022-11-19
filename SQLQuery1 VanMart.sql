CREATE DATABASE VanMartOlap

USE VanMartOlap

--DROP TABLE CustomerDimension

CREATE TABLE CustomerDimension (
CustomerCode INT PRIMARY KEY IDENTITY,
CustomerID CHAR(7),
CustomerName VARCHAR(50),
CustomerDOB DATE,
CustomerGender VARCHAR(10),
CustomerAddress VARCHAR(50),
CustomerPhone VARCHAR(50)
)

CREATE TABLE GoodsDimension (
GoodsCode INT PRIMARY KEY IDENTITY,
GoodsID CHAR(7),
GoodsName VARCHAR(50),
GoodsSellingPrice INT,
GoodsBuyingPrice INT,
ValidFrom DATETIME,
ValidTo DATETIME
)
CREATE TABLE StaffDimension (
StaffCode INT PRIMARY KEY IDENTITY,
StaffID CHAR(7),
StaffName VARCHAR(50),
StaffDOB DATE,
StaffSalary INT,
StaffGender VARCHAR(10),
ValidFrom DATETIME,
ValidTo DATETIME
)
CREATE TABLE SupplierDimension (
SupplierCode INT PRIMARY KEY IDENTITY,
SupplierID CHAR(7),
SupplierName VARCHAR(50),
SupplierAddress VARCHAR (50),
CityName VARCHAR (50)
)

CREATE TABLE BranchDimension (
BranchCode INT PRIMARY KEY IDENTITY,
BranchID CHAR(7),
BranchAddress VARCHAR (50),
CityName VARCHAR (50)
)

CREATE TABLE BenefitDimension(
BenefitCode INT PRIMARY KEY IDENTITY,
BenefitID CHAR(7),
BenefitName VARCHAR (50),
BenefitPrice INT,
ValidFrom DATETIME,
ValidTo DATETIME
)

CREATE TABLE TimeDimension(
TimeCode INT PRIMARY KEY IDENTITY,
[DATE] DATE,
[Month] INT,
[Quarter] INT,
[Year] INT
)
--=============
CREATE TABLE SalesFact(
GoodsCode INT,
StaffCode INT,
CustomerCode INT,
BranchCode INT,
TimeCode INT,
[total earning] BIGINT,
[total goods old] BIGINT
)

CREATE TABLE ReturnFact(
GoodsCode INT,
StaffCode INT,
BranchCode INT,
SupplierCode INT,
TimeCode INT,
[total goods return] BIGINT,
[total number of staff] BIGINT
)

CREATE TABLE PurchaseFact(
GoodsCode INT,
StaffCode INT,
CustomerCode INT,
BranchCode INT,
TimeCode INT,
[total purchase cost] BIGINT,
[total goods purchased] BIGINT
)

CREATE TABLE SubscriptionFact(
CustomerCode INT,
StaffCode INT,
BenefitCode INT,
TimeCode INT,
[total subscription earning] BIGINT,
[total number of subscriprion] BIGINT
)

CREATE TABLE FilterTimeStamp (
TableName VARCHAR (50),
LastETL DATETIME
)