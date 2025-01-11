
-- select * from Users
insert into Users
SELECT VW_UcretPersonel.TcKimlikNo [Username]
      ,AdiSoyadi [DisplayName]
      ,'muhasebe@bernak.com.tr' [Email]
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
      ,VW_UcretPersonel.TcKimlikNo [TcKimlikNo]
      ,null [ZirveSubelerId]
      ,0 [AcceptedTermsAndConditions]
	  ,null devriyeSubelerId
	  ,null deviceId
  from VW_UcretPersonel
  left join Users on Users.TcKimlikNo collate Turkish_CI_AS = VW_UcretPersonel.TcKimlikNo 
     where   Users.UserId is null and AktifPasif =  'Aktif' and AdiSoyadi  NOT in  ('BÜLENT ÞAKAR','SAÝP ÖZÜAK','CÜNEYT AÞÇIOÐLU')
	 

  --select * from [VW_UcretPersonel]

insert into [UserRoles]
SELECT Users.[UserId]
      ,1 [RoleId]
  FROM [dbo].Users 
left join [UserRoles] on Users.UserId = [UserRoles].UserId and RoleId = 1 
where [UserRoles].UserRoleId is null and len(Users.TcKimlikNo)>3


 