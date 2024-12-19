 

 insert into Users
SELECT [Personel].TcKimlikNo [Username]
      ,Adi + ' ' + Soyadi [DisplayName]
      ,'test@serkansonmez.com' [Email]
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
      ,[Personel].TcKimlikNo [MobilePhoneNumber]
      ,0 [MobilePhoneVerified]
      ,null [TwoFactorAuth]
     ,[Personel].TcKimlikNo
  from [Personel]
  left join Users on Users.MobilePhoneNumber collate Turkish_CI_AS = [Personel].TcKimlikNo  collate Turkish_CI_AS 
     where   Users.UserId is null   and NOT(adi = 'YALÇIN' AND Soyadi = 'KESLER')

	 --select * from Users where DisplayName like 'YALÇIN%'
  
insert into [UserRoles]
SELECT Users.[UserId]
      ,1 [RoleId]
  FROM [dbo].Users 
left join [UserRoles] on Users.UserId = [UserRoles].UserId and RoleId = 1 
where [UserRoles].UserRoleId is null and len(Users.TcKimlikNo)>3

 

  --select * from VW_PersonelListesi where SubeAd like 'BURSA_BETON_MERKEZ%' and AktifPasif = 'Aktif'