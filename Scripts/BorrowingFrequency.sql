-- 3. Borrowing Frequency using Window Functions
WITH BorrowerFrequency AS (
    SELECT
        BorrowerID,
        COUNT(*) AS BorrowingFrequency,
        ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS BorrowerRank
    FROM Library.Loans
    GROUP BY BorrowerID
)
SELECT
    BorrowerID,
    BorrowingFrequency,
    BorrowerRank
FROM BorrowerFrequency;
