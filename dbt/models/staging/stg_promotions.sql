select week_start, promo_name, discount_pct
from {{ source('raw', 'promotions') }}
