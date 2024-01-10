DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS Holding;
DROP TABLE IF EXISTS Coin;
DROP TABLE IF EXISTS Login;
DROP TABLE IF EXISTS Setting;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Watchlist;

CREATE TABLE IF NOT EXISTS User (
	userID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	username VARCHAR(32) UNIQUE NOT NULL,
	password BLOB NOT NULL,
	key BLOB NOT NULL
);

CREATE TABLE IF NOT EXISTS Activity (
	activityID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	userID INTEGER NOT NULL,
	activityTransactionID VARCHAR(32) UNIQUE NOT NULL,
	activityAssetID BLOB NOT NULL,
	activityAssetSymbol BLOB NOT NULL,
	activityAssetType BLOB NOT NULL,
	activityDate BLOB NOT NULL,
	activityType BLOB NOT NULL,
	activityAssetAmount BLOB NOT NULL,
	activityFee BLOB NOT NULL,
	activityNotes BLOB NOT NULL,
	activityExchange BLOB NOT NULL,
	activityPair BLOB NOT NULL,
	activityPrice BLOB NOT NULL,
	activityFrom BLOB NOT NULL,
	activityTo BLOB NOT NULL,
	FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Holding (
	holdingID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	userID INTEGER NOT NULL,
	holdingAssetID BLOB NOT NULL,
	holdingAssetSymbol BLOB NOT NULL,
	holdingAssetAmount BLOB NOT NULL,
	holdingAssetType BLOB NOT NULL,
	FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Coin (
	coinID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	assetID VARCHAR(64) NOT NULL UNIQUE,
	assetSymbol VARCHAR(16) NOT NULL,
	data BLOB
);

CREATE TABLE IF NOT EXISTS Login (
	loginID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	userID INTEGER NOT NULL,
	loginToken VARCHAR(64) NOT NULL UNIQUE,
	loginDate DATETIME NOT NULL,
	FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Setting (
	settingID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	userID INTEGER NOT NULL UNIQUE,
	userSettings BLOB NOT NULL,
	FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Stock (
	stockID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	assetSymbol VARCHAR(16) NOT NULL UNIQUE,
	historicalData BLOB,
	priceData BLOB
);

CREATE TABLE IF NOT EXISTS Watchlist (
	watchlistID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	userID INTEGER NOT NULL,
	assetID BLOB NOT NULL,
	assetSymbol BLOB NOT NULL,
	assetType BLOB NOT NULL,
	FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Message (
	messageID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	userID INTEGER NOT NULL,
	message BLOB NOT NULL,
	messageDate DATETIME NOT NULL,
	FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS [Transaction] (
	transactionID VARCHAR(32) NOT NULL PRIMARY KEY,
	userID INTEGER NOT NULL,
	transactionType BLOB NOT NULL,
	transactionDate BLOB NOT NULL,
	transactionCategory BLOB NOT NULL,
	transactionAmount BLOB NOT NULL,
	transactionNotes BLOB NOT NULL,
	FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Budget (
	budgetID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	userID INTEGER NOT NULL UNIQUE,
	budgetData BLOB NOT NULL,
	FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE IF NOT EXISTS VIEW UserLogin
AS 
SELECT 
	userID, 
	username, 
	loginID, 
	loginToken,
	loginDate
FROM
	Login
INNER JOIN
	User USING (userID);