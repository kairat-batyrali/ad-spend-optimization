select m.n_mart, s.n_sales
from (select count(*) as n_mart from {{ ref('mart_weekly_mmm') }}) m
cross join (select count(*) as n_sales from {{ ref('stg_weekly_sales') }}) s
where m.n_mart <> s.n_sales
