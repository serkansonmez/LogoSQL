USE [CEZVE]
GO
/****** Object:  Trigger [dbo].[LG_STFICHE_DEL_324_01_AC]    Script Date: 27.06.2024 17:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--ALTER TRIGGER [dbo].[LG_STFICHE_DEL_324_01_AC] ON [dbo].[LG_324_01_STFICHE]
--FOR DELETE
--AS
--DECLARE @LREF      INT
--DECLARE @TRCODE     SMALLINT
--DECLARE @NETTOTAL   FLOAT
--DECLARE @REPORTRATE FLOAT
--DECLARE @BILLED     SMALLINT
--DECLARE @STATUS     SMALLINT
--DECLARE @CANCELLED  SMALLINT
--DECLARE @AFFECTCOLLTRL SMALLINT
--DECLARE @AFFECTRISK SMALLINT
--SELECT @LREF= LOGICALREF      FROM DELETED D
 
-- UPDATE AltinCezveB2B_Default_v1..UretimEmri with(readpast) set UretimFisiNo=null,UretimFisiRef=null where UretimFisiRef =@LREF

--  UPDATE AltinCezveB2B_Default_v1..UretimEmri with(readpast) set SarfFisiNo=null,SarfFisiRef=null where SarfFisiRef =@LREF
 
ALTER procedure SP_UretimEmriFisNoTemizle as 
-- 1- UretimFisiRef kontrolü
 update  AltinCezveB2B_Default_v1..UretimEmri set  UretimFisiNo=null,UretimFisiRef=null where UretimEmriId In ( SELECT UretimEmri.UretimEmriId FROM AltinCezveB2B_Default_v1..UretimEmri 
  LEFT JOIN CEZVE..LG_324_01_STFICHE WITH (NOLOCK) ON LG_324_01_STFICHE.LOGICALREF = UretimEmri.UretimFisiRef
  WHERE  CEZVE..LG_324_01_STFICHE.LOGICALREF IS NULL AND UretimFisiRef is not null)

-- 2- SarfFisiRef kontrolü
 update  AltinCezveB2B_Default_v1..UretimEmri set  SarfFisiNo=null,SarfFisiRef=null  where UretimEmriId In ( SELECT UretimEmri.UretimEmriId  FROM AltinCezveB2B_Default_v1..UretimEmri 
  LEFT JOIN  CEZVE..LG_324_01_STFICHE WITH (NOLOCK) ON LG_324_01_STFICHE.LOGICALREF = UretimEmri.SarfFisiRef
  WHERE  CEZVE..LG_324_01_STFICHE.LOGICALREF IS NULL AND SarfFisiRef is not null)