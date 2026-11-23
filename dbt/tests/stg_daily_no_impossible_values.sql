select *
from {{ ref('stg_daily_performance') }}
where spend < 0 or revenue < 0 or clicks > impressions or conversions > clicks
