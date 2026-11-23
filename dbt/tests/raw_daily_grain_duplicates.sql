{{ config(severity='warn') }}
select date, campaign_id, count(*) as n
from {{ source('raw', 'daily_performance') }}
group by date, campaign_id
having count(*) > 1
