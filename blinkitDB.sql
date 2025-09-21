select * from blinkit ;

---0
update blinkit 
set item_fat_content = 
		case 
			when item_fat_content = 'LF' then 'Low Fat'
			when item_fat_content = 'reg' then 'Regular'
			else item_fat_content
	    end ;

select distinct(item_fat_content) from blinkit ;
--- 1
select concat(CAST(sum(Total_Sales)/ 1000000 as decimal (10 ,2) ), 'M') as total_revenue_Millions 
from blinkit ;

--- 2
select round(sum(total_sales),2) as total_saless from blinkit ; 

---3
select round(avg(total_sales) ,0) as Sales_avg from blinkit ;

---4
select count(*) as no_of_item from blinkit ;

---5
select concat(CAST(sum(Total_Sales)/ 1000000 as decimal (10 ,2) ), 'M') as total_revenue_Millions 
from blinkit 
where Item_Fat_Content = 'Low Fat';

---6
select concat(CAST(sum(Total_Sales)/ 1000000 as decimal (10 ,2) ), 'M') as total_revenue_Millions 
from blinkit 
where Outlet_Establishment_Year = 2022;

---7
select count(*) as no_of_item from blinkit 
where Outlet_Establishment_Year = 2022;

---8
select round(avg(total_sales) ,0) as Sales_avg from blinkit 
where Outlet_Establishment_Year = 2022;

---9
select round(avg(rating),2) as rating_avg from blinkit ;


--- Total Sales by Fat Content:
	--Objective: Analyze the impact of fat content on total sales.
	--Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
	Select Item_Fat_Content ,
			concat(cast(sum(total_sales)/1000 as decimal (10 , 2 )),'K') as total_revenue_in_K,
			cast(avg(total_sales) as decimal (10 , 2 ))as avg_total_revenue,
			count(*) as no_of_item ,
			cast(avg(Rating) as decimal (10 , 2 ))as avg_Rating 
	from blinkit
	group by Item_Fat_Content
	order by total_revenue_in_K desc;


--- Total Sales by Item Type:
	--Objective: Identify the performance of different item types in terms of total sales.
	--Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
	select Item_Type , 
			cast(sum(total_sales) as decimal(10,2)) as total_sales,
			cast(avg(total_sales) as decimal(10,2)) as avg_sales,
			count(*) as No_Of_item , 
			cast(avg(Rating) as decimal(10,2)) as avg_rating
	from blinkit 
	group by Item_Type 
	order by total_sales desc ;


--- Fat Content by Outlet for Total Sales:
	--Objective: Compare total sales across different outlets segmented by fat content.
	--Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
	select Outlet_Identifier , Item_Fat_Content ,
			cast(sum(total_sales) as decimal (10,2)) as total_sales 	
	from blinkit
	group by Outlet_Identifier , Item_Fat_Content 
	order by Outlet_Identifier ; 

	select distinct Outlet_Identifier from blinkit
	order by  Outlet_Identifier ;


--- Total Sales by Outlet Establishment:
	--Objective: Evaluate how the age or type of outlet establishment influences total sales.
	select Outlet_Establishment_Year ,
			(year(getdate()) - Outlet_Establishment_Year ) as outlet_age , 	
			concat(cast(sum(total_sales )/1000 as decimal (10,2)) , 'K' ) as total_sales ,
			cast(avg(total_sales ) as decimal (10,2))  as avg_total_sales  ,
			count(*) as NO_Of_item
	from blinkit 
	group by Outlet_Establishment_Year
	order by outlet_age ;


--- Percentage of Sales by Outlet Size:
	--Objective: Analyze the correlation between outlet size and total sales.
    select Outlet_Size , 
			cast(sum(total_sales) as decimal (10,2) ) as total_sales ,
			concat(CAST(SUM(total_sales) * 100.0 / (SELECT SUM(total_sales) FROM blinkit) AS DECIMAL(10,2)) , '%' ) AS Percentage_Of_Sales
	from blinkit 
	group by Outlet_Size 
	order by Percentage_Of_Sales ;


--- Sales by Outlet Location:
	--Objective: Assess the geographic distribution of sales across different locations.
	select Outlet_Location_Type , 
			cast(sum(total_sales) as decimal(10,2)) as total_sales,
			cast(avg(total_sales) as decimal(10,2)) as avg_sales,
			count(*) as No_Of_item , 
			cast(avg(Rating) as decimal(10,2)) as avg_rating
	from blinkit 
	group by Outlet_Location_Type 
	order by Outlet_Location_Type ;


--- All Metrics by Outlet Type:
	--Objective: Provide a comprehensive view of all key metrics (Total Sales, Average Sales, Number of Items, Average Rating) broken down by different outlet types.
	select Outlet_Type , 
			cast(sum(total_sales) as decimal(10,2)) as total_sales,
			cast(avg(total_sales) as decimal(10,2)) as avg_sales,
			count(*) as No_Of_item , 
			cast(avg(Rating) as decimal(10,2)) as avg_rating
	from blinkit 
	group by Outlet_Type 
	order by total_sales desc  ;


-------------------------------------------------------------------------- END -----------------------------------------------------------------------------------------------------
