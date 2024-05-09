--  14. SQL Stored Procedure with Temp Table

CREATE PROCEDURE sp_ListOverdueBooksByBorrower
AS BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#OverdueBorrowers') IS NOT NULL
        DROP TABLE #OverdueBorrowers;

    SELECT DISTINCT
        br.BorrowerID,
        br.FirstName,
        br.LastName
    INTO #OverdueBorrowers
    FROM Library.Borrowers br
    JOIN Library.Loans l ON br.BorrowerID = l.BorrowerID
    WHERE l.DueDate < GETDATE() AND (l.DateReturned IS NULL OR l.DateReturned > l.DueDate);

    SELECT
        ob.BorrowerID,
        ob.FirstName,
        ob.LastName,
        b.Title AS BookTitle,
        l.DateBorrowed,
        l.DueDate,
		l.DateReturned
    FROM #OverdueBorrowers ob
    JOIN Library.Loans l ON ob.BorrowerID = l.BorrowerID
    JOIN Library.Books b ON l.BookID = b.BookID
    WHERE l.DueDate < GETDATE() AND (l.DateReturned IS NULL OR l.DateReturned > l.DueDate)
    ORDER BY ob.BorrowerID, l.DueDate;
END;

-- exe
EXEC sp_ListOverdueBooksByBorrower;