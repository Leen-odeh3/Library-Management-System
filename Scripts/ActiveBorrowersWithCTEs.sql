-- 2. Active Borrowers with CTEs
--  Identify borrowers who've borrowed 2 or more books but haven't returned any using CTEs.
WITH ActiveLoans AS (
    SELECT 
        LoanID,
        BorrowerID,
        BookID
    FROM Library.Loans
    WHERE DateReturned IS NULL
),
ActiveBorrowers AS (
    SELECT 
        BorrowerID, 
        COUNT(BookID) as BooksBorrowed
    FROM ActiveLoans
    GROUP BY BorrowerID
    HAVING COUNT(BookID) >= 2
)
SELECT
    ab.BorrowerID,
    b.FirstName,
    b.LastName,
    b.Email,
    ab.BooksBorrowed
FROM Library.Borrowers b
JOIN ActiveBorrowers ab ON b.BorrowerID = ab.BorrowerID
ORDER BY ab.BooksBorrowed DESC;
