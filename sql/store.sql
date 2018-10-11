CREATE DEFINER=`root`@`%` PROCEDURE `testline_operation_log_store`()
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
BEGIN

  	declare current_times time default null;
  	declare hour24 time default null;
    set current_times=(SELECT CURTIME());
    #set current_times=(select str_to_date("23:59:59",'%H:%i:%s'));
	 set hour24=(select str_to_date("16:49:51",'%H:%i:%s'));    
		#ECHO current_times[0];
    IF current_times != hour24  
    THEN  
        update testline_operation_log   
			set reserved_sum=reserved_sum+(
					select 
					IF(line_status='Reserved', 1, 0) as line_status
					from testline_info
					where testline_info.testline_name=testline_operation_log.testline_name
				),
				Unuse_sum=Unuse_sum+(
					select 
					IF(line_status='Unuse', 1, 0) as line_status
					from testline_info
					where testline_info.testline_name=testline_operation_log.testline_name
				),
				Unavaliable_sum=Unavaliable_sum+(
					select 
					IF(line_status='updatefail', 1, 0) as line_status
					from testline_info
					where testline_info.testline_name=testline_operation_log.testline_name
				),
				insert_time=NOW();

    ELSE 
		insert into testline_operation_log (testline_name)
		select testline_name 
		from testline_info
		where 
			testline_name!=testline_info.testline_name;
      update testline_operation_log
		set reserved_sum=0,
			Unuse_sum=0,
			Unavaliable_sum=0,
			insert_time=NOW(); 
    END IF;
	
END