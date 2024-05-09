-- 7. Database Function - Book Borrowing Frequency

CREATE FUNCTION fn_BookBorrowingFrequency (@BookID INT)

RETURNS INT
AS BEGIN
    DECLARE @BorrowingCount INT;

    SELECT @BorrowingCount = COUNT(*)
    FROM Library.Loans
    WHERE BookID = @BookID;

    RETURN @BorrowingCount;
END


SELECT dbo.fn_BookBorrowingFrequency(7) AS BorrowingFrequency;