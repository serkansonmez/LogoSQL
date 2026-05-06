--delete from Users where UserId >1
--delete from OnayTalepleri
--delete from UserPermissions where UserId>1
--delete from OlayTutanak where UserId>1
--delete from Devriye.DevriyeGpsPilotKullanicilar
--select * from VW_PersonelListesi where SubeAd like 'GÜV%' AND AktifPasif = 'Aktif'
  insert into Users  
SELECT [VW_PersonelListesi].TcKimlikNo [Username]
      ,ad + ' ' + Soyadi [DisplayName]
      ,'muhasebe@osperas.com.tr' [Email]
      ,'site' [Source]
      ,'HVOIi5nhPxg45py8JoMYNHiV0JlfntkgT2sE5546PHDWLtHXNBTZ1FcRvpICKb1A76CJBhM3rKFAEnNO+GOS3Q' [PasswordHash]
      ,'xieyy' [PasswordSalt]
      ,null [LastDirectoryUpdate]
      ,null [UserImage]
      ,getdate() as [InsertDate]
      ,1 [InsertUserId]
      ,getdate() [UpdateDate]
      ,1 [UpdateUserId]
      ,1 [IsActive]
      ,null [MobilePhoneNumber]
      ,0 [MobilePhoneVerified]
      ,null [TwoFactorAuth]
      ,[VW_PersonelListesi].TcKimlikNo [TcKimlikNo]
      ,null [ZirveSubelerId]
      ,1 [AcceptedTermsAndConditions]
      ,null as devriyesubelerId
  from [VW_PersonelListesi]
  left join Users on Users.TcKimlikNo collate SQL_Latin1_General_CP1_CI_AS = [VW_PersonelListesi].TcKimlikNo 
    where SubeAd like 'GÜV%' AND AktifPasif = 'Aktif' AND Users.UserId is null


  
insert into [UserRoles]
SELECT Users.[UserId]
      ,1 [RoleId]
  FROM [dbo].Users 
left join [UserRoles] on Users.UserId = [UserRoles].UserId and RoleId = 1 
where [UserRoles].UserRoleId is null and len(Users.TcKimlikNo)>3



SELECT [VW_PersonelListBox].TcKimlikNo [Username]
      ,AdiSoyadi [DisplayName]
      ,'muhasebe@gezenguvenlik.com' [Email]
      ,'site' [Source]
      ,'HVOIi5nhPxg45py8JoMYNHiV0JlfntkgT2sE5546PHDWLtHXNBTZ1FcRvpICKb1A76CJBhM3rKFAEnNO+GOS3Q' [PasswordHash]
      ,'xieyy' [PasswordSalt]
      ,null [LastDirectoryUpdate]
      ,null [UserImage]
      ,getdate() as [InsertDate]
      ,1 [InsertUserId]
      ,getdate() [UpdateDate]
      ,1 [UpdateUserId]
      ,1 [IsActive]
      ,null [MobilePhoneNumber]
      ,0 [MobilePhoneVerified]
      ,null [TwoFactorAuth]
      ,[VW_PersonelListBox].TcKimlikNo [TcKimlikNo]
      ,null [ZirveSubelerId]
      ,0 [AcceptedTermsAndConditions]
  from [VW_PersonelListBox]
  left join Users on Users.TcKimlikNo collate Turkish_CI_AS = [VW_PersonelListBox].TcKimlikNo 
     where [VW_PersonelListBox].TcKimlikNo in (
select TcKimlikNo from VW_PersonelListesi where SubeAd like 'BURSA_BETON_MERKEZ%' and AktifPasif = 'Aktif') and Users.UserId is null


--sonar oto için açýlacak


insert into Users
SELECT [VW_PersonelListBox].TcKimlikNo [Username]
      ,AdiSoyadi [DisplayName]
      ,'muhasebe@gezenguvenlik.com' [Email]
      ,'site' [Source]
      ,'HVOIi5nhPxg45py8JoMYNHiV0JlfntkgT2sE5546PHDWLtHXNBTZ1FcRvpICKb1A76CJBhM3rKFAEnNO+GOS3Q' [PasswordHash]
      ,'xieyy' [PasswordSalt]
      ,null [LastDirectoryUpdate]
      ,null [UserImage]
      ,getdate() as [InsertDate]
      ,1 [InsertUserId]
      ,getdate() [UpdateDate]
      ,1 [UpdateUserId]
      ,1 [IsActive]
      ,null [MobilePhoneNumber]
      ,0 [MobilePhoneVerified]
      ,null [TwoFactorAuth]
      ,[VW_PersonelListBox].TcKimlikNo [TcKimlikNo]
      ,null [ZirveSubelerId]
      ,0 [AcceptedTermsAndConditions]
  from [VW_PersonelListBox]
  left join Users on Users.TcKimlikNo collate Turkish_CI_AS = [VW_PersonelListBox].TcKimlikNo 
     where [VW_PersonelListBox].TcKimlikNo in (
select TcKimlikNo from VW_PersonelListesi where GRUPKODU like 'sonar oto%' and AktifPasif = 'Aktif') and Users.UserId is null
  
insert into [UserRoles]
SELECT Users.[UserId]
      ,1 [RoleId]
  FROM [dbo].Users 
left join [UserRoles] on Users.UserId = [UserRoles].UserId and RoleId = 1 
where [UserRoles].UserRoleId is null and len(Users.TcKimlikNo)>3



 

update Users set AcceptedTermsAndConditions= 1   where UserId in (53,
54,
55)
