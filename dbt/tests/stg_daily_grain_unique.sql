select date, campaign_id, count(*) as n
from {{ ref('stg_daily_performance') }}
group by date, campaign_id
having count(*) > 1
