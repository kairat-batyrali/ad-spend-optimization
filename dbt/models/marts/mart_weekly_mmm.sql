with channel_wide as (
    select
        week_start,
        sum(spend) filter (where channel = 'Google Search') as spend_google_search,
        sum(spend) filter (where channel = 'Meta')          as spend_meta,
        sum(spend) filter (where channel = 'TikTok')        as spend_tiktok,
        sum(spend) filter (where channel = 'YouTube')       as spend_youtube,
        sum(spend)                                          as spend_total
    from {{ ref('int_weekly_channel') }}
    group by 1
)
select
    s.week_start,
    s.total_sales,
    p.promo_name is not null           as is_promo_week,
    coalesce(p.discount_pct, 0)        as discount_pct,
    coalesce(w.spend_google_search, 0) as spend_google_search,
    coalesce(w.spend_meta, 0)          as spend_meta,
    coalesce(w.spend_tiktok, 0)        as spend_tiktok,
    coalesce(w.spend_youtube, 0)       as spend_youtube,
    coalesce(w.spend_total, 0)         as spend_total
from {{ ref('stg_weekly_sales') }} as s
left join {{ ref('stg_promotions') }} as p on s.week_start = p.week_start
left join channel_wide as w on s.week_start = w.week_start
