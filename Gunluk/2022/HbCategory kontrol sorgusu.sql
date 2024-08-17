select * from hbCategory where name like 'hp%'
select * from hbCategory where ParentCategoryId = 0

select * from hbCategory where Leaf = 0
select * from hbCategory where ParentCategoryId = 19001
select * from hbCategory where CategoryId = 60001546

select * from HbCategoryAttribute where CategoryId = 4 and Mandatory = 1
select * from HbCategoryBaseAttribute where CategoryId = 4 and Mandatory = 1

select * from HbCategoryAttribute where Id like 'fields%'
select * from HbCategoryAttributeValues where CategoryId = 4 and AttributeId = '00002AK9'
select count( * ) from HbCategoryAttributeValues