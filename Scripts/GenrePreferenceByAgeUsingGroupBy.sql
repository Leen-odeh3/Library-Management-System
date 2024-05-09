-- Genre Preference by Age using Group By and Having:
--  Determine the preferred genre of different age groups of borrowers. (Groups are (0,10), (11,20), (21,30)…)

DECLARE @Size INT = 10;
WITH BorrowerGenreFrequency AS (
    SELECT
        l.BorrowerID,
        bg.GenreID,
        BorrowingFrequency = COUNT(l.LoanID)
    FROM Library.Loans l
    JOIN Library.BookGenres bg ON l.BookID = bg.BookID
    GROUP BY l.BorrowerID, bg.GenreID
),
BorrowerGroups AS (
    SELECT
        BorrowerID,
        GroupNumber = DATEDIFF(YEAR, DateOfBirth, GETDATE()) / @Size
    FROM Library.Borrowers
),
BorrowerGroupsGenreFrequency AS (
    SELECT
        bgf.GenreID,
        bg.GroupNumber,
        BorrowingFrequency = SUM(bgf.BorrowingFrequency)
    FROM BorrowerGenreFrequency bgf
    JOIN BorrowerGroups bg ON bgf.BorrowerID = bg.BorrowerID
	GROUP BY bgf.GenreID, bg.GroupNumber
)
SELECT
    g.GenreID,
    g.Name,
    BorrowingFrequency = ISNULL(bggf.BorrowingFrequency, 0),
    GroupAge = CONCAT(bggf.GroupNumber * @Size, ' - ', (bggf.GroupNumber + 1) * @Size - 1),
    Popularity = DENSE_RANK() OVER (PARTITION BY bggf.GroupNumber ORDER BY ISNULL(bggf.BorrowingFrequency, 0) DESC)
FROM Library.Genres g
LEFT JOIN BorrowerGroupsGenreFrequency bggf ON g.GenreID = bggf.GenreID
ORDER BY bggf.GroupNumber, ISNULL(bggf.BorrowingFrequency, 0) DESC;
