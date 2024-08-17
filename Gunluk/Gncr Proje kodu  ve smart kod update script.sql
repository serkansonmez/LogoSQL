select BNTRACKINGNO, * from LG_119_23_BNFLINE where  BNTRACKINGNO<> ''

select BNTRACKINGNO, * from LG_119_22_BNFLINE where  BNTRACKINGNO<> ''


SELECT * , 'UPDATE OnayTalepleri SET ProjeKodu =  ''090.20.010.058.004''    where id=' + BNTRACKINGNO  FROM (
select BNTRACKINGNO from LG_118_20_BNFLINE where  BNTRACKINGNO<> ''
UNION ALL
select BNTRACKINGNO from LG_118_21_BNFLINE where  BNTRACKINGNO<> ''
UNION ALL
select BNTRACKINGNO from LG_118_22_BNFLINE where  BNTRACKINGNO<> ''
UNION ALL
select BNTRACKINGNO from LG_118_23_BNFLINE where  BNTRACKINGNO<> '') tbl

SELECT * FROM GINSOFT_NET_PROD..OnayTalepleri order by id desc
'090.20.010.058.004'

 -- update  GINSOFT_NET_PROD..OnayTalepleri set ProjeKodu =  '090.20.010.058.004' where FirmaId = 120 and  ProjeKodu is null 

-- select * into GINSOFT_NET_PROD..OnayTalepleri_20231110 from  GINSOFT_NET_PROD..OnayTalepleri



SELECT * , 'UPDATE OnayTalepleri SET ProjeKodu =  ''090.20.010.058.004''    where id=' + BNTRACKINGNO  FROM (
select BNTRACKINGNO from LG_106_20_BNFLINE where  BNTRACKINGNO<> '' and ISNUMERIC( BNTRACKINGNO)= 1 
UNION ALL
select BNTRACKINGNO from LG_106_21_BNFLINE where  BNTRACKINGNO<> '' and ISNUMERIC( BNTRACKINGNO)= 1 
UNION ALL
select BNTRACKINGNO from LG_106_22_BNFLINE where  BNTRACKINGNO<> '' and ISNUMERIC( BNTRACKINGNO)= 1 
UNION ALL
select BNTRACKINGNO from LG_106_23_BNFLINE where  BNTRACKINGNO<> ''  and ISNUMERIC( BNTRACKINGNO)= 1    ) tbl


select *  from  GINSOFT_NET_PROD..OnayTalepleri WHERE Tarih > '20200101' order by id desc