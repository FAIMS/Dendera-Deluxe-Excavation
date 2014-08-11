select uuid, aenttypename || ': ' || group_concat(coalesce(measure || ' ' || vocabname || '(' ||freetext||')',  measure || ' (' || freetext ||')',  vocabname || ' (' || freetext ||')',  measure || ' ' || vocabname ,  vocabname || ' (' || freetext || ')',  measure || ' (' || freetext || ')',  measure,  vocabname,  freetext,  measure,  vocabname,  freetext), ' | ') as response
        FROM (select * from latestNonDeletedArchentIdentifiers order by case attributename when 'Sample ID' then 1 when 'Sample Type' then 2 else attributename end )
        WHERE aenttypename = 'Sample' 
        and uuid in (select uuid 
            from  latestnondeletedarchent join aenttype using (aenttypeid) join idealaent using (aenttypeid) join attributekey using (attributeid) left outer join latestnondeletedaentvalue using (uuid, attributeid) left outer join vocabulary using (vocabid) 
            where ('12' = 'All' 
                AND (freetext like '%4%' 
                    or vocabname like '%4%' 
                    or measure like '%4%'))
            OR ('123' != 'All' 
                AND coalesce(vocabname, freetext) = '{0No_Observation}'
                AND attributename = 'Sample Type'
                AND (freetext like '%No%'
                or vocabname like '%No%'
                or measure like '%No%'
            ))
        ) GROUP BY uuid 
        order by response;