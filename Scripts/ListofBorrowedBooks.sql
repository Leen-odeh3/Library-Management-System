-- 1. List of Borrowed Books
-- Retrieve all books borrowed by a specific borrower, including those currently unreturned.
DECLARE @BorrowerId INT = 5;

SELECT  B.Title, B.Author, L.DateBorrowed, L.DueDate
FROM Library.Loans AS L
JOIN Library.Books AS B ON L.BookID = B.BookID
WHERE L.BorrowerID = @BorrowerId;
