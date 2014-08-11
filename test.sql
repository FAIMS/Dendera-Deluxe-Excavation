.mode tabs
.header on
select vocabid, vocabname, attributename from vocabulary join attributekey using (attributeid) where attributename like 'Soil Texture%';

select vocabid from vocabulary join attributekey using (attributeid)where attributeName = 'Soil Texture' and vocabname = (select vocabname
 from vocabulary join attributekey using (attributeid)
 where trim(vocabname,'{}1234567890.') like (select trim(vocabname,'{}1234567890.')  from vocabulary where vocabid = 16293152)
 and attributeName = 'Soil Texture');