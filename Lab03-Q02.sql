--2) You are an analyst for Census Bureau and tasked to find US cities, that are losing their population year after year, for example, Akron Ohio?
      -- hint use Citypops tables and make sure the cities are in the USA.

;with cte as (
	select *, row_number() over(partition by City, Province order by [Year]) as row_num
	from Citypops
	where Country = 'USA'
	--and City='Akron'
)
select a.City,a.Province,max(a.row_num) as max_row, count(b.row_num) as cnt
from cte as a
left join cte as b on a.City = b.City and 
					  a.Province =b.Province and 
					  a.row_num+1 = b.row_num and
					  a.[Population] > b.[Population]
group by a.City,a.Province
having max(a.row_num)-1 = count(b.row_num); 
