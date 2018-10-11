-- Check if table exist then drop table
IF OBJECT_ID('Student') IS NOT NULL
	DROP TABLE Student;
go

-- create table
CREATE TABLE Student(
	StudentID INT NOT NULL IDENTITY,
	FirstName VARCHAR(20),
	LastName  VARCHAR(20),
	Email	  VARCHAR(50),
	CONSTRAINT PK_Student PRIMARY KEY(StudentID)
);
go

IF OBJECT_ID('Class') IS NOT NULL
	DROP TABLE Class;
go
CREATE TABLE Class(
	ClassID		INT NOT NULL IDENTITY,
	Title		VARCHAR(50),
	[Date]		DATE,
	ClassRoom	VARCHAR(20),
	Capacity	INT,
	CONSTRAINT PK_Class PRIMARY KEY(ClassID)
);
go

IF OBJECT_ID('ClassStudent') IS NOT NULL
	DROP TABLE ClassStudent;
go
CREATE TABLE ClassStudent(
	ClassID INT,
	StudentID INT,
	CONSTRAINT PK_ClassStudent PRIMARY KEY(ClassID,StudentID)
);
go

-- Add foreign key between ClassStudent and Class tables
ALTER TABLE ClassStudent ADD CONSTRAINT fk_ClassStudent_Class FOREIGN KEY (ClassID) REFERENCES Class (ClassID);
-- Add foreign key between ClassStudent and Student tables
ALTER TABLE ClassStudent ADD CONSTRAINT fk_ClassStudent_Student FOREIGN KEY (StudentID) REFERENCES Student (StudentID);

--insert 

INSERT INTO Student([FirstName],[LastName],[Email])
	VALUES('John','Doe', 'j.doe@colordotech.edu'),
	('Jane','Doe','ja.doe@coloradotech.edu');

INSERT INTO Class([Title],[Date],[ClassRoom],[Capacity])
	VALUES('Fundamental database','10/10/2018','r415',20),
	('SQL','10/10/2018','r415',10);

INSERT INTO ClassStudent(ClassID,StudentID)
	VALUES(1,1),
		  (1,2),
		  (2,2);

-- Check what we have
select *
from Student;

select *
from Class;

select *
from ClassStudent;
--/*
select s.*,c.*
from ClassStudent as cs
join Class as c on c.ClassID = cs.ClassID
join Student as s on s.StudentID = cs.StudentID;
--*/

