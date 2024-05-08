-- 6. Database Function - Calculate Overdue Fees
CREATE OR ALTER FUNCTION fn_CalculateOverdueFees
(
    @LoanID INT
)
RETURNS DECIMAL(10, 2)
AS BEGIN
    DECLARE @DueDate DATE;
    DECLARE @DateReturned DATE;
    DECLARE @OverdueDays INT;
    DECLARE @OverdueFee DECIMAL(10, 2);

    SELECT @DueDate = DueDate, @DateReturned = DateReturned
    FROM Library.Loans
    WHERE LoanID = @LoanID;

    SET @OverdueDays = DATEDIFF(DAY, @DueDate, COALESCE(@DateReturned, GETDATE()));

    IF @OverdueDays > 0
    BEGIN
        IF @OverdueDays <= 30
        BEGIN
            SET @OverdueFee = @OverdueDays * 1.00;
        END
        ELSE
        BEGIN
            SET @OverdueFee = (30 * 1.00) + ((@OverdueDays - 30) * 2.00);
        END
    END
    ELSE
    BEGIN
        SET @OverdueFee = 0.00; 
    END

    RETURN @OverdueFee;
	End


