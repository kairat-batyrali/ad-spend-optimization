-- One row per campaign per day.
-- Raw has exact-copy duplicates (campaign 1137), so select distinct.
select distinct
    date, campaign_id, spend, impressions, clicks, conversions, revenue
from {{ source('raw', 'daily_performance') }}
