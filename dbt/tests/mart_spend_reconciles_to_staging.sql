select m.mart_spend, s.stg_spend
from (select sum(spend_total) as mart_spend from {{ ref('mart_weekly_mmm') }}) m
cross join (select sum(spend) as stg_spend from {{ ref('stg_daily_performance') }}) s
where abs(m.mart_spend - s.stg_spend) > 0.01
