CREATE SCHEMA Library;

CREATE TABLE Library.Borrowers (
    BorrowerID INT PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    DateOfBirth DATE NOT NULL,
    MembershipDate DATE NOT NULL
);

CREATE TABLE Library.Books (
    BookID INT PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Author NVARCHAR(255) NOT NULL,
    ISBN NVARCHAR(70) UNIQUE NOT NULL,
    PublishedDate DATE NOT NULL,
    ShelfLocation NVARCHAR(100) NOT NULL,
    CurrentStatus NVARCHAR(20) CHECK (CurrentStatus IN ('Available', 'Borrowed'))
);

CREATE TABLE Library.Genres (
    GenreID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);

CREATE TABLE Library.BookGenres (
    BookID INT NOT NULL,
    GenreID INT NOT NULL,
    PRIMARY KEY (BookID, GenreID),
    FOREIGN KEY (BookID) REFERENCES Library.Books(BookID),
    FOREIGN KEY (GenreID) REFERENCES Library.Genres(GenreID)
);

CREATE TABLE Library.Loans (
    LoanID INT PRIMARY KEY,
    BookID INT NOT NULL,
    BorrowerID INT NOT NULL,
    DateBorrowed DATE NOT NULL,
    DueDate DATE NOT NULL,
    DateReturned DATE, 
    FOREIGN KEY (BookID) REFERENCES Library.Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Library.Borrowers(BorrowerID)
);




