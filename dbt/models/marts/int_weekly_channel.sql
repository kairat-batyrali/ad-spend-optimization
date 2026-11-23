select
    date_trunc('week', d.date)::date as week_start,
    c.channel,
    sum(d.spend) as spend,
    sum(d.impressions) as impressions,
    sum(d.clicks) as clicks,
    sum(d.conversions) as conversions,
    sum(d.revenue) as attributed_revenue
from {{ ref('stg_daily_performance') }} as d
inner join {{ ref('stg_campaigns') }} as c on d.campaign_id = c.campaign_id
group by 1, 2
