-- 12. Trigger Implementation

CREATE TABLE Library.AuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT NOT NULL,
    StatusChange NVARCHAR(255),
    ChangeDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookID) REFERENCES Library.Books(BookID)
);


CREATE TRIGGER trg_BookStatusChange
ON Library.Loans
AFTER INSERT, UPDATE, DELETE
AS BEGIN
    SET NOCOUNT ON;

    IF (SELECT COUNT(*) FROM inserted) > 0 AND (SELECT COUNT(*) FROM deleted) = 0
    BEGIN
        INSERT INTO Library.AuditLog (BookID, StatusChange)
        SELECT i.BookID, 'Borrowed'
        FROM inserted i
        WHERE i.DateReturned IS NULL;
    END

    IF (SELECT COUNT(*) FROM deleted) > 0 AND (SELECT COUNT(*) FROM inserted) = 0
    BEGIN
        INSERT INTO Library.AuditLog (BookID, StatusChange)
        SELECT d.BookID, 'Loan Record Deleted'
        FROM deleted d
        WHERE d.DateReturned IS NULL;
    END

  
    IF (SELECT COUNT(*) FROM inserted) > 0 AND (SELECT COUNT(*) FROM deleted) > 0
    BEGIN
        INSERT INTO Library.AuditLog (BookID, StatusChange)
        SELECT i.BookID, 'Returned'
        FROM inserted i
        INNER JOIN deleted d ON i.LoanID = d.LoanID
        WHERE i.DateReturned IS NOT NULL AND d.DateReturned IS NULL

        UNION ALL

        SELECT d.BookID, 'Return Date Removed'
        FROM inserted i
        INNER JOIN deleted d ON i.LoanID = d.LoanID
        WHERE i.DateReturned IS NULL AND d.DateReturned IS NOT NULL;
    END
END;