select 'weekly_sales' as tbl, week_start
from {{ ref('stg_weekly_sales') }} where dayname(week_start) <> 'Monday'
union all
select 'promotions', week_start
from {{ ref('stg_promotions') }} where dayname(week_start) <> 'Monday'
