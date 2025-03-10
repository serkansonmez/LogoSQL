 
CREATE NONCLUSTERED INDEX IDX_SehpaHareket_IsEmriNo 
ON SehpaHareket (IsEmriNo) INCLUDE (SehpaAdet, OperasyonTanimiId, Tarih);

CREATE NONCLUSTERED INDEX IDX_OperasyonHareket_IsEmriNo 
ON OperasyonHareket (IsEmriNo) INCLUDE (OperasyonTanimiId, SaglamCamAdet, IsIstasyonlariId, IseBaslangicSaati);

CREATE NONCLUSTERED INDEX IDX_HurdaCamHareket_IsEmriNo 
ON HurdaCamHareket (IsEmriNo) INCLUDE (HurdaCamAdet, OperasyonTanimiId);
