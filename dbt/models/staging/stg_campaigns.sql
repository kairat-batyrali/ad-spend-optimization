select campaign_id, campaign_name, channel, region, language,
       creative_type, objective, start_date, end_date
from {{ source('raw', 'campaigns') }}
