CASE  
WHEN (expression1 IS NOT NULL) THEN expression1  
WHEN (expression2 IS NOT NULL) THEN expression2  
...  
ELSE expressionN  
END 

#########################################
# select


select  
	reserved_sum,
	case
		when reserved_sum<10 then 0
		when reserved_sum>=10 then 1
	end
	as revinfo
from testline_operation_log_backup
where 
	reserved_sum < any (select reserved_sum from testline_operation_log_backup)
	
#****************************************************

select  
	reserved_sum,
	case
		when reserved_sum<10 then 0
		when reserved_sum>=10 then 1
	end
	as revinfo,
	"reserved_sum"=(
	case
		when reserved_sum<10 then 0
		when reserved_sum>=10 then 1
	end)
from testline_operation_log_backup
	order by  
	case
		when reserved_sum<10 then 0
		when reserved_sum>=10 then 1
	end


########################################
##update

UPDATE dbo.DimEmployee  
SET VacationHours =   
    ( CASE  
         WHEN ((VacationHours - 10.00) < 0) THEN VacationHours + 40  
         ELSE (VacationHours + 20.00)   
       END  
    )   
WHERE SalariedFlag = 0; 

##############################################
## having

SELECT JobTitle, MAX(ph1.Rate)AS MaximumRate  
FROM HumanResources.Employee AS e  
JOIN HumanResources.EmployeePayHistory AS ph1 ON e.BusinessEntityID = ph1.BusinessEntityID  
GROUP BY JobTitle  
HAVING (MAX(CASE WHEN Gender = 'M'   
        THEN ph1.Rate   
        ELSE NULL END) > 40.00  
     OR MAX(CASE WHEN Gender  = 'F'   
        THEN ph1.Rate    
        ELSE NULL END) > 42.00)  
ORDER BY MaximumRate DESC;  

############################################
#  


CREATE FUNCTION dbo.GetContactInformation(@BusinessEntityID int)  
    RETURNS @retContactInformation TABLE   
(  
BusinessEntityID int NOT NULL,  
FirstName nvarchar(50) NULL,  
LastName nvarchar(50) NULL,  
ContactType nvarchar(50) NULL,  
    PRIMARY KEY CLUSTERED (BusinessEntityID ASC)  
)   
AS   
-- Returns the first name, last name and contact type for the specified contact.  
BEGIN  
    DECLARE   
        @FirstName nvarchar(50),   
        @LastName nvarchar(50),   
        @ContactType nvarchar(50);  

    -- Get common contact information  
    SELECT   
        @BusinessEntityID = BusinessEntityID,   
@FirstName = FirstName,   
        @LastName = LastName  
    FROM Person.Person   
    WHERE BusinessEntityID = @BusinessEntityID;  

    SET @ContactType =   
        CASE   
            -- Check for employee  
            WHEN EXISTS(SELECT * FROM HumanResources.Employee AS e   
                WHERE e.BusinessEntityID = @BusinessEntityID)   
                THEN 'Employee'  

            -- Check for vendor  
            WHEN EXISTS(SELECT * FROM Person.BusinessEntityContact AS bec  
                WHERE bec.BusinessEntityID = @BusinessEntityID)   
                THEN 'Vendor'  

            -- Check for store  
            WHEN EXISTS(SELECT * FROM Purchasing.Vendor AS v            
                WHERE v.BusinessEntityID = @BusinessEntityID)   
                THEN 'Store Contact'  

            -- Check for individual consumer  
            WHEN EXISTS(SELECT * FROM Sales.Customer AS c   
                WHERE c.PersonID = @BusinessEntityID)   
                THEN 'Consumer'  
        END;  

    -- Return the information to the caller  
    IF @BusinessEntityID IS NOT NULL   
    BEGIN  
        INSERT @retContactInformation  
        SELECT @BusinessEntityID, @FirstName, @LastName, @ContactType;  
    END;  

    RETURN;  
END;  
GO  

SELECT BusinessEntityID, FirstName, LastName, ContactType  
FROM dbo.GetContactInformation(2200);  
GO  
SELECT BusinessEntityID, FirstName, LastName, ContactType  
FROM dbo.GetContactInformation(5);  