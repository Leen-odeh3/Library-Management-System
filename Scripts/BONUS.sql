--  Weekly peak days: The library is planning to employ a new part-time worker. 
-- This worker will work 3 days weekly in the library. From the data you have, determine the most 3 days in the week that have the most share of the loans and display the result of each day as a percentage of all loans. Sort the results from the highest percentage to the lowest percentage.
--  (eg. 25.18% of the loans happen on Monday...)




DECLARE @TotalCount FLOAT;
SELECT @TotalCount = COUNT(*) FROM Library.Loans;
WITH LoanDays AS (
    SELECT
        DATENAME(WEEKDAY, DateBorrowed) AS DayOfWeek,
        COUNT(*) AS LoanCount
    From Library.Loans
    GROUP BY DATENAME(WEEKDAY, DateBorrowed)
),
LoanDayPercentages AS (
    SELECT
        DayOfWeek,
        Percentage = (LoanCount / @TotalCount) * 100
    FROM LoanDays
)
SELECT TOP 3
    DayOfWeek,
    Percentage = ROUND(Percentage, 2)
FROM LoanDayPercentages
ORDER BY ROUND(Percentage, 2) DESC;