select id from fercam_artikel
WHERE id NOT IN
(SELECT id_artikel from fercam_distributor_artikel)

delete from fercam_distributor_artikel where id in (
select fercam_distributor_artikel.id from fercam_distributor_artikel
WHERE id_artikel NOT IN
(SELECT id  from fercam_artikel) )

select * into fercam_distributor_artikel_yedek from fercam_distributor_artikel


select * from fercam_artikel where id = 908



 delete from fercam_distributor_artikel where id in (
select fercam_distributor_artikel.id from fercam_distributor_artikel
WHERE id_distributor NOT IN
(SELECT id  from fercam_distributor) 
 )