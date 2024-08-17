-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create TRIGGER PersonelIzinHareket_AfterUpdate
   ON  PersonelIzinHareket
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @PersonelIzinTurleriId int 
	declare @Tarih datetime
	declare @BaslamaTarihi datetime
	declare @BitisTarihi datetime
	declare @ToplamSureGun int 
	declare @AcilDurumAdres varchar(512) 
	declare @IzinTelefonNo varchar(512)
	declare @PersonelIzinId int

	select  
      
       @PersonelIzinTurleriId = inserted.[PersonelIzinTurleriId]
       
      ,@Tarih = inserted.[Tarih]
      ,@BaslamaTarihi = inserted.[BaslamaTarihi]
      ,@BitisTarihi = inserted.[BitisTarihi]
      ,@ToplamSureGun = [ToplamSureGun]
     
      ,@AcilDurumAdres = [AcilDurumAdresTelefon]
      ,@IzinTelefonNo = inserted.VekaletKisi
     
	  ,@PersonelIzinId = PersonelIzin.Id
        from inserted
		 
   	 --LEFT JOIN [VW_ONAY_TALEPLERI_LISTESI_YENI] on   [OnayTalepleriId]  = [VW_ONAY_TALEPLERI_LISTESI_YENI].OnayNo
	 left join PersonelIzin on PersonelIzin.PersonelIzinHareketId = inserted.Id
	 where PersonelIzin.Id is not null
	 if (@PersonelIzinId>0)
	 begin
	     update PersonelIzin set 
		      BaslangicTarihi = @BaslamaTarihi
			  ,BitisTarihi = @BitisTarihi
			  ,IzinGunu = @ToplamSureGun
			  ,PersonelIzinTurleriId = @PersonelIzinTurleriId
			  ,IzinAdresi = @AcilDurumAdres
			  ,IzinTelefonNo = @IzinTelefonNo
		 where Id = @PersonelIzinId
	 end
END
GO
--select * from VW_PersonelIzinHareketYeni