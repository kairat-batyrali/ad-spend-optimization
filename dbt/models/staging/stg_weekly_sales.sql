select week_start, total_sales
from {{ source('raw', 'weekly_sales') }}
