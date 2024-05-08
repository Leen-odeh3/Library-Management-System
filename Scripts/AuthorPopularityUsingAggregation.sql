-- 9. Author Popularity using Aggregation

WITH AuthorFrequency AS (
    SELECT
        b.Author,
        BorrowingCount = COUNT(l.LoanID)
    FROM Library.Books b
    LEFT JOIN Library.Loans l ON b.BookID = l.BookID
	GROUP BY b.Author
)
SELECT
    Author,
    BorrowingCount,
    Popularity = DENSE_RANK() OVER (ORDER BY BorrowingCount DESC)
FROM AuthorFrequency
ORDER BY BorrowingCount DESC, Author;
