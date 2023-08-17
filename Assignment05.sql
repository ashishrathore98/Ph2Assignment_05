-- Create the database
Create Database Assessment05Db;

-- Use the database
use Assessment05Db;

-- Create the schema
create schema bank;

-- Create the Customer table
create table bank.Customer (
    Cld int primary key,
    CName varchar(50) NOT NULL,
    CEmail varchar(50) NOT NULL unique,
    Contact varchar(20) NOT NULL unique,
    CPwd as RIGHT(CName + CAST(Cld as varchar) + LEFT(Contact, 2), 4) persisted
);


-- Insert data into Customer table
INSERT INTO bank.Customer (Cld, CName, CEmail, Contact)
VALUES
    (1001, 'Sam Dicosta', 'sam.d@example.com', '9988776655'),
    (1002, 'Ravi Singh', 'ravi.singh@example.com', '9753109811');

INSERT INTO bank.Customer (Cld, CName, CEmail, Contact)
VALUES
    (1002, 'Amit', 'amit@example.com', '9988776622'),
    (1003, 'Shalu', 'shalu@example.com', '9998877665');

select * from bank.Customer

-- Create the Maillnfo table
CREATE TABLE bank.Maillnfo (
    MailTo varchar(50),
    MailDate date,
    MailMessage varchar(100)
);

-- Create the trigger trgMailToCust
create trigger trgMailToCust
on bank.Customer
after insert
AS
BEGIN
    INSERT INTO bank.Maillnfo (MailTo, MailDate, MailMessage)
    SELECT i.CEmail, GETDATE(), 'Your net banking password is: ' + i.CPwd + '. It is valid up to 2 days only. Update it.'
    FROM inserted i;
END;

select * from bank.Maillnfo;