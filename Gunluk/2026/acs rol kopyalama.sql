select * from Roles

select * from UserRoles where RoleId=5 

--efatura
insert into UserRoles
select UserId,15 from UserRoles where RoleId=5 
--satýnalma
insert into UserRoles
select UserId,14 from UserRoles where RoleId=1 