SELECT 
HbCategoryAttribute.HbCategoryAttributeId ,
HbCategoryAttribute.CategoryId ,
HbCategoryAttribute.Name ,
HbCategoryAttribute.Id ,
Mandatory ,
Type_ ,
MultiValue  FROM HbCategoryAttribute WITH (NOLOCK) 
LEFT JOIN HbCategoryAttributeValues on HbCategoryAttributeValues.CategoryId = HbCategoryAttribute.CategoryId and 
HbCategoryAttributeValues.AttributeId = HbCategoryAttribute.Id
where HbCategoryAttributeValues.HbCategoryAttributeValuesId is  null

--select * from HbCategoryAttributeValues