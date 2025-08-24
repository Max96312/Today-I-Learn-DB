select name, email, created_at as event_date from users
union all
select name, email, retired_date as event_date from retired_users
order by event_date desc;