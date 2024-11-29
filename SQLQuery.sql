--TASK 1:
CREATE DATABASE DBAChallenge;

--TASK 2:
USE DBAChallenge;

CREATE TABLE Dept(
	DeptID INT IDENTITY NOT NULL,
	DeptName VARCHAR(50),
	CONSTRAINT pk_Dept PRIMARY KEY (DeptID)
);

CREATE TABLE Emp(
	EmpID INT IDENTITY NOT NULL,
	EmpFname VARCHAR(50),
	EmpLname VARCHAR(50),
	DeptID INT NULL,
	IsActive BIT,
	CONSTRAINT pk_Emp PRIMARY KEY (EmpID),
	CONSTRAINT fk_Emp_Dept FOREIGN KEY(DeptID) REFERENCES Dept(DeptID) --ON DELETE SET NULL ON UPDATE CASCADE
);

--Task 3:

BACKUP DATABASE DBAChallenge TO DISK='E:\Google Drive\Study\Db_Challenges\DBAChallengeFullStackLabs\BackupData1.bak' WITH INIT;

--Task 4:

SET IDENTITY_INSERT Dept ON;
INSERT INTO Dept (DeptID,DeptName) VALUES(1,'Ex-Emp');
INSERT INTO Dept (DeptID,DeptName) VALUES(2,'General Affairs');
INSERT INTO Dept (DeptID,DeptName) VALUES(3,'Accounting');
INSERT INTO Dept (DeptID,DeptName) VALUES(4,'Public Relations');
INSERT INTO Dept (DeptID,DeptName) VALUES(5,'Information Technology');
SET IDENTITY_INSERT Dept OFF;

SET IDENTITY_INSERT Emp ON;
INSERT INTO Emp (EmpID,EmpFname,EmpLname,DeptID,IsActive) VALUES(28,'Paul','Rodriguez',3,0);
INSERT INTO Emp (EmpID,EmpFname,EmpLname,DeptID,IsActive) VALUES(37,'Sidney','Poitier',2,1);
INSERT INTO Emp (EmpID,EmpFname,EmpLname,DeptID,IsActive) VALUES(99,'Samuel','Jackson',5,1);
INSERT INTO Emp (EmpID,EmpFname,EmpLname,DeptID,IsActive) VALUES(81,'Ruben','Blades',5,1);
INSERT INTO Emp (EmpID,EmpFname,EmpLname,DeptID,IsActive) VALUES(17,'Keanu','Reeves',5,0);
INSERT INTO Emp (EmpID,EmpFname,EmpLname,DeptID,IsActive) VALUES(33,'Harrison','Ford',1,0);
INSERT INTO Emp (EmpID,EmpFname,EmpLname,DeptID,IsActive) VALUES(49,'Mario','Rodriguez',3,1);
SET IDENTITY_INSERT Emp OFF;

SELECT E.EmpID,
	   E.EmpFname,
	   E.EmpLname,
	   E.DeptID,
	   D.DeptName,
	   E.IsActive
  FROM Emp E
 LEFT JOIN Dept D ON D.DeptID = E.DeptID

--Task 5:

BACKUP DATABASE DBAChallenge TO DISK='E:\Google Drive\Study\Db_Challenges\DBAChallengeFullStackLabs\BackupData2.bak' WITH INIT;

--Task 6:

ALTER TABLE Emp ADD EmpMidInitial VARCHAR(1) NULL;

UPDATE Emp SET EmpMidInitial = 'D' WHERE EmpLname = 'Rodriguez';

UPDATE Emp SET EmpMidInitial = '' WHERE EmpLname != 'Rodriguez';

SELECT E.EmpID,
	   E.EmpFname,
	   E.EmpMidInitial,
	   E.EmpLname,
	   E.DeptID,
	   D.DeptName,
	   E.IsActive
  FROM Emp E
 LEFT JOIN Dept D ON D.DeptID = E.DeptID
 ORDER BY E.EmpID ASC

 -- Task 7:
  
BACKUP DATABASE DBAChallenge TO DISK='E:\Google Drive\Study\Db_Challenges\DBAChallengeFullStackLabs\BackupData3.bak' WITH INIT;

--TASK 8:

CREATE NONCLUSTERED INDEX NIndex ON Emp(EmpID) INCLUDE (EmpFname, EmpMidInitial, EmpLname);

--Task 9:

DBCC CHECKDB (DBAChallenge);

--Task 10:

ALTER INDEX ALL ON EMP REBUILD;

ALTER INDEX ALL ON Dept REBUILD;

sp_updatestats

--Task 11:
CREATE PROCEDURE SPList
AS
BEGIN
SELECT E.EmpID,
	   E.EmpFname,
	   E.EmpMidInitial,
	   E.EmpLname,
	   E.DeptID,
	   D.DeptName,
	   E.IsActive
  FROM Emp E
 LEFT JOIN Dept D ON D.DeptID = E.DeptID
 ORDER BY E.EmpID ASC
 END

 EXEC SPList

 --Task 12:

 USE master;
 
 RESTORE DATABASE DBAChallenge FROM DISK='E:\Google Drive\Study\Db_Challenges\DBAChallengeFullStackLabs\BackupData2.bak' WITH REPLACE;

 USE DBAChallenge

 --Task 13:
 USE master;

 CREATE LOGIN [api-user] WITH PASSWORD='passsword';

 USE DBAChallenge

 CREATE USER [api-user] FOR LOGIN [api-user];

 ALTER ROLE [db_datareader] ADD MEMBER[api-user];

 --Task 14:

 GRANT SELECT ON Dept TO [api-user];

 GRANT SELECT, INSERT, UPDATE, DELETE ON Emp TO [api-user];