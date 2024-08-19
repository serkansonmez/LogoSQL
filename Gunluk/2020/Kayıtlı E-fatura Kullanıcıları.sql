create view VW_EfaturaKullanicilarLogo as 
select Identifier,Title,Type from EfaturaKullanicilarLogo where Type2='Invoice' and DeletionTime is null group by Identifier,Title,Type

select LEN(Identifier), * from EfaturaKullanicilarLogo where Type2='Invoice' and DeletionTime is null