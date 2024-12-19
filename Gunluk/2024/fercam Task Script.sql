CREATE TABLE TaskStatus (
    StatusId INT PRIMARY KEY IDENTITY(1,1),
    StatusName NVARCHAR(50) NOT NULL
);

CREATE TABLE Tasks (
    TaskId INT PRIMARY KEY IDENTITY(1,1),
    CreatedBy NVARCHAR(100) NOT NULL,        -- Kayýt Eden
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(), -- Kayýt Tarihi
    StartDate DATETIME,                      -- Görev Baþlatma Tarihi
    StatusId INT,                            -- Görev Statüsü (FK)
    AssignedBy NVARCHAR(100) NOT NULL,       -- Görevi Atayan Kiþi
    AssignedTo NVARCHAR(100) NOT NULL,       -- Görev Atanan Kiþi
    NotifiedPersons NVARCHAR(MAX),           -- Bilgisi Olanlar (string, virgülle ayrýlmýþ)
    TaskTitle NVARCHAR(200) NOT NULL,        -- Görev Baþlýðý
    TaskDescription NVARCHAR(MAX),           -- Görev Açýklamasý
    Attachments NVARCHAR(MAX),               -- Dosya Ekleri (dosya yolu veya URL)
    DeadlineDate DATETIME,                   -- Deadline Tarihi
    WorkDetails NVARCHAR(MAX),               -- Yapýlan Ýþ Detayý
    EndDate DATETIME,                        -- Ýþ Bitiþ Tarihi
    FOREIGN KEY (StatusId) REFERENCES TaskStatus(StatusId)
);

-- Görev statüsü için verileri ekleyelim
INSERT INTO TaskStatus (StatusName) VALUES ('Baþlamadý');
INSERT INTO TaskStatus (StatusName) VALUES ('Devam Ediyor');
INSERT INTO TaskStatus (StatusName) VALUES ('Tamamlandý');
INSERT INTO TaskStatus (StatusName) VALUES ('Ýptal');