DECLARE @Year INT = 2023;
DECLARE @Month INT = 12;
WITH GenreBorrows AS (
    SELECT
        bg.GenreID,
        COUNT(l.LoanID) AS LoanCount
    FROM Library.BookGenres bg
    LEFT JOIN Library.Books b ON bg.BookID = b.BookID
    LEFT JOIN Library.Loans l ON b.BookID = l.BookID 
        AND YEAR(l.DateBorrowed) = @Year 
        AND MONTH(l.DateBorrowed) = @Month
    GROUP BY bg.GenreID
)
SELECT
    g.GenreID,
    g.Name,
    LoanCount = ISNULL(gb.LoanCount, 0),
    PopularityRank = DENSE_RANK() OVER (ORDER BY ISNULL(gb.LoanCount, 0) DESC)
FROM Library.Genres g
LEFT JOIN GenreBorrows gb ON g.GenreID = gb.GenreID
ORDER BY PopularityRank;