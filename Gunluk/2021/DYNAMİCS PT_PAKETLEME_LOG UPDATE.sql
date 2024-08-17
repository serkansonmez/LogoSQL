select * from PT_PAKETLEME_LOG where BOX>0

select 
'PK' +  Substring(FISNO,1, 2) +  'K' + Substring(FISNO,3, 4) +  REPLACE(STR(BOX, 3), SPACE(1), '0') ,
* from PT_PAKETLEME_LOG where BOX>0

UPDATE  PT_PAKETLEME_LOG SET BARKOD = 'PK' +  Substring(FISNO,1, 2) +  'K' + Substring(FISNO,3, 4) +  REPLACE(STR(BOX, 3), SPACE(1), '0')  where BOX>0

--211208090052

rpt.xrBarCode1.Text = "PK" + txtPaketlemeFisNo.Text.Substring(0, 2) + "K" + txtPaketlemeFisNo.Text.Substring(2, 4) +  txtBoxNo.Text.PadLeft(3,'0');

PK21K1208001