-- 5. Stored Procedure
-- Procedure Name: sp_AddNewBorrower

DROP PROCEDURE IF EXISTS [sp_AddNewBorrower];

CREATE OR ALTER PROCEDURE sp_AddNewBorrower
    @FirstName NVARCHAR(50), 
    @LastName NVARCHAR(50), 
    @Email NVARCHAR(255), 
    @DateOfBirth DATE, 
    @MembershipDate DATE,
    @NewBorrowerID INT OUT
AS BEGIN
    SET NOCOUNT ON;

    IF EXISTS(SELECT 1 FROM Library.Borrowers WHERE Email = @Email)
    BEGIN
        THROW 50000, 'Email already exists.', 1;
    END
    ELSE
    BEGIN
        INSERT INTO Library.Borrowers (FirstName, LastName, Email, DateOfBirth, MembershipDate)
        VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);

        SET @NewBorrowerID = SCOPE_IDENTITY();
    END
END;
