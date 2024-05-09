-- 11.Stored Procedure - Borrowed Books Report:

CREATE PROCEDURE sp_BorrowedBooksReport
    @StartDate DATE,
    @EndDate DATE
AS BEGIN
    SELECT
        k.Title AS BookTitle,
        k.Author AS BookAuthor,
        w.FirstName + ' ' + w.LastName AS BorrowerName,
        l.DateBorrowed,
        l.DueDate
    FROM Library.Loans l
    JOIN Library.Books k ON k.BookID = l.BookID
    JOIN Library.Borrowers w ON w.BorrowerID = l.BorrowerID
    WHERE l.DateBorrowed BETWEEN @StartDate AND @EndDate;
END

-- Exe:
EXEC sp_BorrowedBooksReport @StartDate = '2024-01-01', @EndDate = '2024-08-01';
