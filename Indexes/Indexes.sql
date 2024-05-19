-- Books 

CREATE NONCLUSTERED INDEX idx_Books_Covering 
ON Library.Books(BookID, Title, CurrentStatus);

-- Loans 

CREATE NONCLUSTERED INDEX idx_Loans_BorrowerID_DateBorrowed 
ON Library.Loans(BorrowerID, DateBorrowed)
INCLUDE (BookID, DateReturned)
WHERE DateReturned IS NULL;

CREATE NONCLUSTERED INDEX idx_Loans_ActiveLoans 
ON Library.Loans (BorrowerID, DateReturned)
INCLUDE (BookID) 
WHERE DateReturned IS NULL;

CREATE NONCLUSTERED INDEX idx_Loans_BookID_DateBorrowed 
ON Library.Loans(BookID, DateBorrowed);


-- BookGenres 

CREATE NONCLUSTERED INDEX idx_BookGenres_BookID_GenreID 
ON Library.BookGenres(BookID, GenreID);


-- Borrowers

CREATE NONCLUSTERED INDEX idx_Borrowers_Covering 
ON Library.Borrowers(BorrowerID)
INCLUDE (FirstName, LastName, Email); 





