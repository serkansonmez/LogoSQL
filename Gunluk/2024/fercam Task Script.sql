CREATE TABLE TaskStatus (
    StatusId INT PRIMARY KEY IDENTITY(1,1),
    StatusName NVARCHAR(50) NOT NULL
);

CREATE TABLE Tasks (
    TaskId INT PRIMARY KEY IDENTITY(1,1),
    CreatedBy NVARCHAR(100) NOT NULL,        -- Kay�t Eden
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(), -- Kay�t Tarihi
    StartDate DATETIME,                      -- G�rev Ba�latma Tarihi
    StatusId INT,                            -- G�rev Stat�s� (FK)
    AssignedBy NVARCHAR(100) NOT NULL,       -- G�revi Atayan Ki�i
    AssignedTo NVARCHAR(100) NOT NULL,       -- G�rev Atanan Ki�i
    NotifiedPersons NVARCHAR(MAX),           -- Bilgisi Olanlar (string, virg�lle ayr�lm��)
    TaskTitle NVARCHAR(200) NOT NULL,        -- G�rev Ba�l���
    TaskDescription NVARCHAR(MAX),           -- G�rev A��klamas�
    Attachments NVARCHAR(MAX),               -- Dosya Ekleri (dosya yolu veya URL)
    DeadlineDate DATETIME,                   -- Deadline Tarihi
    WorkDetails NVARCHAR(MAX),               -- Yap�lan �� Detay�
    EndDate DATETIME,                        -- �� Biti� Tarihi
    FOREIGN KEY (StatusId) REFERENCES TaskStatus(StatusId)
);

-- G�rev stat�s� i�in verileri ekleyelim
INSERT INTO TaskStatus (StatusName) VALUES ('Ba�lamad�');
INSERT INTO TaskStatus (StatusName) VALUES ('Devam Ediyor');
INSERT INTO TaskStatus (StatusName) VALUES ('Tamamland�');
INSERT INTO TaskStatus (StatusName) VALUES ('�ptal');