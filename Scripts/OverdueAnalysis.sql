-- 8. Overdue Analysis
--  List all books overdue by more than 30 days with their associated borrowers
DECLARE @OverdueDays INT = 10;
WITH OverdueBooks AS (
    SELECT
        BookID,
        BorrowerID,
	    	DateBorrowed,
        DueDate,
        DateReturned,
        OverdueDays = DATEDIFF(DAY, DueDate, COALESCE(DateReturned, GETDATE()))
    FROM Library.Loans
    WHERE DATEDIFF(DAY, DueDate, COALESCE(DateReturned, GETDATE())) > @OverdueDays
)
    SELECT
        k.BookID,
        k.Title,
        k.Author,
        w.BorrowerID,
        w.FirstName,
        w.LastName,
        w.Email,
        o.DateBorrowed,
        o.DueDate,
        o.DateReturned,
        o.OverdueDays
    FROM OverdueBooks o
    JOIN Library.Books k ON o.BookID = k.BookID
    JOIN Library.Borrowers w ON o.BorrowerID = w.BorrowerID
    ORDER BY OverdueDays DESC, w.FirstName;

