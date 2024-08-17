USE [ArgelasB2B_Default_v1]
GO

/****** Object:  StoredProcedure [dbo].[SP_CariHesapEkstresi]    Script Date: 6.02.2021 09:56:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 

alter PROCEDURE [dbo].[SP_GecmisFiyatListeleriniSil]
( @AktarimTuru varchar(3),  @ListeTarihi datetime)
as 
begin
    delete from FiyatListeleri with(readpast) where AktarimTuru = cast(@AktarimTuru as int) and ListeTarihi<cast(@ListeTarihi as date)

end

			
         
 
  


