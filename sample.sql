select distinct uuid from latestnondeletedaentvalue join latestnondeletedarchent using (uuid) join aenttype using (aenttypeid) where aenttypename = 'Sample';
 




select group_concat(response, '\n') from ( select attributename || ': ' || coalesce(vocabname, freetext) as response from ( 
       select uuid from latestnondeletedarchent join latestnondeletedaentreln using (uuid) 
           where uuid = 1000011404695942831 )
           join latestnondeletedaentvalue using (uuid) join attributekey using (attributeid) left outer join vocabulary using (attributeid, vocabid) 
               where attributename in ('Sample ID', 'Sample Volume', 'Sample Weight', 'Context ID', 'Sample Type') 
               and coalesce(vocabname, freetext) is not null 
               and coalesce(vocabname, freetext) != '{0No_Observation}'
           group by uuid, attributename 
      order by case attributename when 'Sample ID' then 1 when 'Sample Weight' then 2 when 'Sample Volume' then 4 when 'Date Opened' then 5 when 'Date Closed' then 6 end); 
        