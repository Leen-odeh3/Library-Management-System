-- Books 

CREATE NONCLUSTERED INDEX idx_Books_Covering 
ON Library.Books(BookID, Author)
INCLUDE (Title);

-- Loans 

CREATE NONCLUSTERED INDEX idx_Loans_BookID_DateBorrowed 
ON Library.Loans(BookID, DateBorrowed);

CREATE NONCLUSTERED INDEX idx_Loans_BorrowerID_DateBorrowed 
ON Library.Loans(BorrowerID, DateBorrowed);

CREATE NONCLUSTERED INDEX idx_Loans_ActiveLoans 
ON Library.Loans (BorrowerID, DateReturned)
INCLUDE (BookID) 
WHERE DateReturned IS NULL;

CREATE NONCLUSTERED INDEX idx_Loans_DateBorrowed 
ON Library.Loans(DateBorrowed);

CREATE NONCLUSTERED INDEX idx_Loans_DueDate_DateReturned 
ON Library.Loans(DueDate, DateReturned)
INCLUDE (BookID, BorrowerID, DateBorrowed);


-- BookGenres 

CREATE NONCLUSTERED INDEX idx_BookGenres_BookID 
ON Library.BookGenres(BookID);

CREATE NONCLUSTERED INDEX idx_BookGenres_GenreID 
ON Library.BookGenres(GenreID);


-- Borrowers

CREATE NONCLUSTERED INDEX idx_Borrowers_DateOfBirth 
ON Library.Borrowers(DateOfBirth);

CREATE NONCLUSTERED INDEX idx_Borrowers_Covering 
ON Library.Borrowers(BorrowerID)
INCLUDE (FirstName, LastName, Email); 





