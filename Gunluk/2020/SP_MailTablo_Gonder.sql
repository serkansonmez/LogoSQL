SELECT * FROM 

--exec [SP_MailTablo_Gonder]
 create  Procedure [dbo].[SP_MailTablo_Gonder] as
DECLARE  @rc INT
DECLARE  @Id INT
DECLARE  @Gonderen VARCHAR(255)
DECLARE  @Kime VARCHAR(255) 
DECLARE  @Bilgi VARCHAR(255)
DECLARE  @Gizli VARCHAR(255)
DECLARE  @Oncelik VARCHAR(255)
DECLARE  @Konu VARCHAR(2048)
DECLARE  @Mesaj VARCHAR(max)
 


DECLARE pro113 CURSOR FOR
SELECT [Id]
      ,[Gonderen]
      ,[Kime]
      ,[Bilgi]
      ,[Gizli]
      ,[Oncelik]
      ,[Konu]
      ,[Mesaj]
      
  FROM [dbo].[MailTablosu] where UlasimDurumu<>1
OPEN pro113
FETCH NEXT FROM pro113
INTO @Id,@Gonderen,@Kime,@Bilgi,@Gizli,@Oncelik,@Konu,@Mesaj 
WHILE @@FETCH_STATUS = 0
BEGIN


	BEGIN TRY
           exec msdb.dbo.sp_send_dbmail
        @profile_name = 'sql mail service',
	 
	 	@recipients  = @Kime,
	  	@copy_recipients = @Bilgi,
		@blind_copy_recipients =  @Gizli,
		@importance   = 'NORMAL',
		@subject    =  @Konu,
        @body_format= 'HTML',
		@body    = @Mesaj
	END TRY
	BEGIN CATCH
	 
		PRINT ERROR_NUMBER();
		PRINT ERROR_MESSAGE();
		SET @rc = ERROR_NUMBER();
		UPDATE [MailTablosu] SET UlasimDurumu=2,UlasimZamani=GETDATE(),UlasimDurumuAciklama=ERROR_MESSAGE() WHERE Id = @Id
	END CATCH

    select @rc

   if @rc is null
   begin
        UPDATE [MailTablosu] SET UlasimDurumu=1,UlasimZamani=GETDATE(),UlasimDurumuAciklama='Mail Gonderildi' WHERE Id = @Id
   end
FETCH NEXT FROM pro113
INTO @Id,@Gonderen,@Kime,@Bilgi,@Gizli,@Oncelik,@Konu,@Mesaj 
END
CLOSE pro113
DEALLOCATE pro113

