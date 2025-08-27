select
	name,
    birth_date,
    case
		when year(birth_date) >= 1990 then '1990년대생'
        when year(birth_date) >= 1980 then '1980년대생'
        else '그 이전 출생'
	end as birth_decade
from users;

select
    case
		when year(birth_date) >= 1990 then '1990년대생'
        when year(birth_date) >= 1980 then '1980년대생'
        else '그 이전 출생'
	end as birth_decade,
    count(*) as customer_count
from users
group by 
    case
		when year(birth_date) >= 1990 then '1990년대생'
        when year(birth_date) >= 1980 then '1980년대생'
        else '그 이전 출생'
	end;
    
select
	case
		when year(birth_date) >= 1990 then '1990년대생'
		when year(birth_date) >= 1980 then '1980년대생'
        else '그 이전 출생'
	end as birth_decade,
    count(*) as customer_count
from users
group by birth_decade;