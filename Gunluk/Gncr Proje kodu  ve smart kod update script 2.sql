--1.Gncr Italy, Salary kýsmý için Proje Kodu : '039.10.000.082.082'             Smart Kod= '039.10.000.082.082'
select 
'UPDATE OnayTalepleri set ProjeKodu=''039.10.000.082.082'' , SmartId=''039.10.000.082.082.000.101'' where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%GNCR ITALY%SALARY%'

 --2.Gncr Italy, RENTAL kýsmý için Proje Kodu : '039.10.000.082.082'             Smart Kod= '039.10.000.082.082'
select 
'UPDATE OnayTalepleri set ProjeKodu=''039.10.000.082.082'' , SmartId=''039.10.000.082.082.000.101'' where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%GNCR ITALY%rental%'

  --3.Gncr Italy, tax kýsmý için Proje Kodu : '039.10.000.082.082'             Smart Kod= '039.10.000.082.082'
select 
'UPDATE OnayTalepleri set ProjeKodu=''039.10.000.082.082'' , SmartId=''039.10.000.082.082.000.101'' where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%GNCR ITALY%TAX%'

select 
'UPDATE OnayTalepleri set ProjeKodu=''039.10.000.082.082'' , SmartId=''039.10.000.082.082.000.101'' where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%GNCR ITALY%TAX%'

 --BALIKESÝR GENEL
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.799''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%BALIKESÝR%'

 
 --BALIKESÝR DAVA TAZMÝNATLAR- SOSYAL
  select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.582''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%BALIKESÝR%ÝCRA%'


  --BALIKESÝR ÝÞLETME
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.799''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%BALIKESÝR%sosyal%'

  --kuþadasý GENEL
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.718''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%KUÞADASI%'

 
 --BALIKESÝR AKARYAKIT
  select 
'UPDATE OnayTalepleri set ProjeKodu=''090.000.010.106.719''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%AKARYAKIT%'


  --balýkesir diðer ÝÞLETME
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.799''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and RotaAdi like '%BALIKESÝR%SAT%'



   --istanbul toi
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.863''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and RotaAdi like '%GHY:ORG%'


    --baçeyöb
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.844''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and RotaAdi like '%GHY%baç%'

     --BAÇEYÖB
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.844''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and RotaAdi like '%baçe%'

      --KONYA
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.10.010.106.825''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and RotaAdi like '%KONYA%'

       --uniCOORP
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.898''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%uniCOO%'
        --uniCOORP
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.649''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and    RotaAdi like '%bor%'

         --palermo solar - 039.10.010.082.003	Italia General Cost Project
 select 
'UPDATE OnayTalepleri set ProjeKodu=''039.10.010.082.003''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and    TalepKonusu like '%palermo%'
 
         --monreale solar - 039.10.000.096.096	MONREALE SOLAR SRL COMPANY PROJECT

 select 
'UPDATE OnayTalepleri set ProjeKodu=''039.10.000.096.096''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and    TalepKonusu like '%monre%'
   --ankara 090.000.010.106.583	ANKARA/YENIMAHALLE-DAVA VE TAZMINATLAR
 select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.583''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%ankara%mahK%'


 --090.000.010.106.525	BURSA/KBALIKLI-YONETIMKURULUOZEL
  select 
'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.525''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%sadul%%uça%'

 --039.10.000.092.092	SPV Taranto MT SRL Company Project
   select 
'UPDATE OnayTalepleri set ProjeKodu=''380.10.000.079.079''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND ProjeKodu is null and TalepKonusu like '%sadul%%uça%'

 --090.20.010.058.004	RÜZGAR ENERJÝ-AMASYA RES

    select 
'UPDATE OnayTalepleri set ProjeKodu=''090.20.010.058.004''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND RotaTuru = 'Payment' AND ProjeKodu is null and RotaAdi like '%Italia holding%'


 --039.10.000.082.082	GNCR ITALIA HOLDING SRL COMPANY PROJECT
     select 
'UPDATE OnayTalepleri set ProjeKodu=''039.10.000.082.082''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND RotaTuru = 'Payment' AND ProjeKodu is null and RotaAdi like '%Principe XI%'

 --039.10.000.097.097	PALERMO SOLAR SRL COMPANY PROJECT
     select 
'UPDATE OnayTalepleri set ProjeKodu=''039.10.000.097.097''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND RotaTuru = 'Payment' AND ProjeKodu is null and RotaAdi like '%palermo%'

  --039.10.000.097.097	PALERMO SOLAR SRL COMPANY PROJECT
     select 
'UPDATE OnayTalepleri set ProjeKodu=''380.10.000.079.079''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND RotaTuru = 'Payment' AND ProjeKodu is null and RotaAdi like '%ign%'

   --380.10.000.080.080	ignatpil
     select 
'UPDATE OnayTalepleri set ProjeKodu=''380.10.000.080.080''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND RotaTuru = 'Payment' AND ProjeKodu is null and RotaAdi like '%Ignatpil SPP Project Payments%'

    --380.10.000.080.080	ignatpil
     select 
'UPDATE OnayTalepleri set ProjeKodu=''380.10.010.080.382''   where id=' + CAST(OnayNo as varchar(200)),* 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND RotaTuru = 'Payment' AND ProjeKodu is null and RotaAdi like '%CEO Þahsi Ödemeleri%'


  --090.000.010.106.713	BURSA/KBALIKLI-VERGI RESIM HARC

   select DISTINCT
--'UPDATE OnayTalepleri set ProjeKodu=''090.00.010.106.713''   where id=' + CAST(OnayNo as varchar(200)),
[OnayNo]
      ,[Tarih]
      ,[TalepEden]
      ,[TalepKonusu]
      ,[OnayGrubu]
      ,[DurumKodu]
      ,[Durum]
      ,[ProjeMasrafMerkeziId]
      ,[ProjePhaseId]
      ,[SiraNo]
      ,[OnayIslemleriId]
      ,[Kime]
      ,[Bilgi]
      ,[Gizli]
      ,[AdimSiraNo]
      ,[Csum]
      ,[OnaylayacakId]
      ,[OnaylayacakAdiSoyadi]
      ,[OnaylayacakParola]
      ,[TalepEdenId]
      ,[OnaylamaTarih]
      ,[OnayDurumu]
      ,[SubeAdi]
      ,[TalepTutari]
      ,[Firma]
      ,[RotaTuru]
      ,[RotaAdi]
      ,[AltLimit]
      ,[UstLimit]
      ,[ParolaHash]
      ,[BankaAdi]
      ,[OnayTurleriId]
      ,[Yil]
      ,[Ay]
      ,[VW_TigerDovizTurleriId]
      ,[DovizCinsi]
      ,[DovizAciklama]
      
      ,[FirmaId]
      ,[ProjeKodu]
      ,[LogoFisNo]
      ,[DeadlineDate]
      ,[SmartCode]
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE Tarih > '20200101' AND RotaTuru = 'Payment' and ProjeKodu is null
 ORDER BY Tarih desc --and TalepKonusu like 'HÝZM%VERG%'





 --select * from ProjeSektor

 --SELECT * FROM OnayTalepleri where id = 106728
 --select * from VW_TabloMasrafMerkezi WHERE DetayKod like 'tax'

--SELECT * into OnayTalepleri_20231113 FROM OnayTalepleri 

select DISTINCT * 
 from VW_ONAY_TALEPLERI_LISTESI_YENI WHERE  FirmaId IN (106 ,76) and Tarih > '20210101' AND ProjeKodu is   null  