select * from ServisMarkaIndirimOranlari
left join VW_LastikMarkalarTumu on  VW_LastikMarkalarTumu.Marka   = ServisMarkaIndirimOranlari.marka collate SQL_Latin1_General_CP1_CI_AS
left join ServisKullanicilar on ServisKullanicilar.ServisKullanicilarId = ServisMarkaIndirimOranlari.ServisKullanicilarId
--where VW_LastikMarkalarTumu.Marka is null or ServisKullanicilar.ServisKullanicilarId is null

-- ServisMarkaIndirimOranlari i
insert into ServisMarkaIndirimOranlari
select tbl.ServisKullanicilarId,tbl.Marka,0 KomisyonOrani from (select ServisKullanicilarId,Marka from VW_LastikMarkalarTumu,ServisKullanicilar) tbl 
left join 
ServisMarkaIndirimOranlari 
on ServisMarkaIndirimOranlari.ServisKullanicilarId = tbl.ServisKullanicilarId and 
ServisMarkaIndirimOranlari.Marka = tbl.Marka collate SQL_Latin1_General_CP1_CI_AS
where ServisMarkaIndirimOranlari.ServisKullanicilarId is  null
and tbl.Marka is not null
 


select * from ServisMarkaIndirimOranlari