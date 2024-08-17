create function fnc_PazaryeriDesiHesapla(@Desi float, @TrendKargoId int)
returns float
 
AS
begin
declare @Desi float = 5
declare @TrendKargoId int = 2
declare @Fiyat float = 0 
declare @TabanFiyat float = 0 
declare @TekliFiyat float = 0 
declare @FarkDesi Float
declare @AltDesi float = 0 
declare @SonFiyat float = 0 
--declare @FarkDesi float = 0 
select @Fiyat= Fiyat,@AltDesi=AltDesi,@TekliFiyat=Fiyat from TrendKargoFiyat where TrendKargoId = @TrendKargoId and @Desi between AltDesi and UstDesi and TekHesapla = 1
if (@Fiyat>0)
begin
    select top 1 @TabanFiyat= Fiyat,@AltDesi=UstDesi from TrendKargoFiyat where TrendKargoId = @TrendKargoId and  AltDesi<@AltDesi  and TekHesapla = 0  order by AltDesi desc
	set @FarkDesi = @Desi - @AltDesi
	--select @Desi  , @AltDesi, @SonFiyat ,  @TekliFiyat , @FarkDesi, @TabanFiyat,  (@TekliFiyat * @FarkDesi) + @TabanFiyat
	set @SonFiyat = (@TekliFiyat * @FarkDesi) + @TabanFiyat
end
else 
begin
    select @Fiyat= Fiyat,@AltDesi=AltDesi,@TekliFiyat=Fiyat from TrendKargoFiyat where TrendKargoId = @TrendKargoId and @Desi between AltDesi and UstDesi and TekHesapla = 0
	set @SonFiyat = @Fiyat
end

return @SonFiyat 

end