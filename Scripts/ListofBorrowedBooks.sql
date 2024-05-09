-- 1. List of Borrowed Books
-- Retrieve all books borrowed by a specific borrower, including those currently unreturned.
declare @BorrowerId int = 5;

SELECT  Library.Books.Title, Books.Author, Loans.DateBorrowed, Loans.DueDate
FROM Library.Loans
JOIN Library.Books ON Loans.BookID = Books.BookID
WHERE Loans.BorrowerID= @BorrowerId;