SELECT CASE WHEN x IS NOT NULL THEN x ELSE 1 END  
from  
(  
SELECT (SELECT Nullable FROM Demo WHERE SomeCol = 1) AS x  
) AS T; 


select insert_time,count(*) as total_num, 
	sum(case reserve_fail_type when 'success' THEN 1 ELSE 0 END) as sucess_num ,
	sum(case reserve_fail_type when 'sync_fail' THEN 1 ELSE 0 END) as sycn_fail_num,
	sum(case reserve_fail_type when 'bug' THEN 1 ELSE 0 END) as bug_num 
	from reserve_info
	group by insert_time 
	limit 30"