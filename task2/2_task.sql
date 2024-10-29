---------------------------------------------------------------
-- Создание таблиц и PK
---------------------------------------------------------------

CREATE TABLE Vaccination
(
    Vaccination_ID       INTEGER     NOT NULL,
    Vaccination_Type_ID  INTEGER     NOT NULL,
    Pet_ID               INTEGER     NOT NULL,
    Vaccination_Date     DATE        NOT NULL,
    Vaccination_Document BYTEA       NOT NULL,
    CONSTRAINT Vaccination_PK PRIMARY KEY (Vaccination_ID)
);

CREATE TABLE Vaccination_Type
(
    Vaccination_Type_ID INTEGER     NOT NULL,
    Name                VARCHAR(15) NOT NULL,
    CONSTRAINT Vaccination_Type_PK PRIMARY KEY (Vaccination_Type_ID)
);

---------------------------------------------------------------
-- Создание FK
---------------------------------------------------------------

ALTER TABLE
    Vaccination
    ADD
        CONSTRAINT FK_Vaccination_Vaccination_Type FOREIGN KEY (Vaccination_Type_ID) REFERENCES Vaccination_Type (Vaccination_Type_ID);

ALTER TABLE
    Vaccination
    ADD
        CONSTRAINT FK_Vaccination_Pet FOREIGN KEY (Pet_ID) REFERENCES Pet (Pet_ID);

---------------------------------------------------------------
-- Заполнение таблиц тестовыми данными
---------------------------------------------------------------

INSERT INTO Vaccination_Type(Vaccination_Type_ID, NAME)
VALUES (1, 'Rabies'),
       (2, 'Distemper');

INSERT INTO Vaccination(Vaccination_ID, Vaccination_Type_ID, Pet_ID, Vaccination_Date, Vaccination_Document)
VALUES (1, 1, 9, '1999-01-08', 'document mock1'::bytea),
       (2, 2, 8, '2002-02-08', 'document mock2'::bytea),
       (3, 2, 7, '2010-01-01', 'document mock3'::bytea);

---------------------------------------------------------------
-- Удаление таблиц
---------------------------------------------------------------
/*
 DROP TABLE Vaccination;
 DROP TABLE Vaccination_Type;
 */