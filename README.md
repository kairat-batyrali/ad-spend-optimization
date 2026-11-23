# Ad Spend Optimization

**Status: in progress**

## The brief

A retail client spent $2M on advertising last year across Google, Meta, TikTok, and YouTube. They want to know which channels actually drive revenue, where spend has hit diminishing returns, and how to reallocate next year's budget.

## Approach

1. **Data:** a Python script generates two years of synthetic data (daily campaign performance, weekly sales, promotions) with known patterns built in. The script and answer key are published once the analysis is done, so the findings can be checked against ground truth.
2. **SQL (DuckDB):** data quality checks and core marketing KPIs (ROAS, CPA, CTR, CPM), plus creative fatigue and segment analysis.
3. **Exploratory analysis (pandas):** trends over time and follow-ups on what the SQL surfaced.
4. **Marketing mix model:** estimates each channel's response curve to measure diminishing returns, validated on a held-out time period.
5. **Streamlit app:** KPI overview and a budget reallocation tool driven by the model.
6. **Tableau Public dashboard:** the weekly view a client would check.
7. **Findings:** recommendations, plus an honest comparison of what the analysis caught and missed against the built-in patterns.

## Tools

Python, DuckDB (SQL), dbt, pandas, NumPy, scikit-learn, statsmodels, Streamlit, Tableau Public, Git

## Progress so far

### Data quality checks ([01_sql_analysis.ipynb](notebooks/01_sql_analysis.ipynb))
- Four tables, 2024-01-01 to 2025-12-28: `campaigns` (229 campaigns), `daily_performance` (one row per campaign per day), `weekly_sales` (104 weeks), `promotions` (12 promo weeks).
- **Duplicates:** campaign 1137 had 14 days (2025-03-03 to 03-16) duplicated as exact copies, which would double-count its spend and revenue. Fixed with a `daily_clean` view (13,062 to 13,048 rows); the raw table is untouched.
- **Clean:** 0 orphan campaign IDs, no impossible values (negative spend, clicks above impressions), both weekly tables start on Monday.
- `promotions` lists promo weeks only, so it must be LEFT JOINed to `weekly_sales` or non-promo weeks drop out.

### Pipeline (dbt)
- The SQL checks from the notebook now run as a dbt project ([dbt/](dbt/)) on DuckDB. Raw CSVs are read in place and never modified.
- Staging models clean each table. `stg_daily_performance` removes the 14 exact-copy duplicate rows in campaign 1137.
- 19 data tests cover uniqueness, nulls, valid channels, orphan campaign IDs, impossible values, and Monday-start weeks.
- The duplicate check is set to warn on the raw data (14 rows, as expected) and must pass on staging.
- `mart_weekly_mmm` is the MMM input table: one row per week (104), with sales, a promo flag, and spend by channel. Two tests confirm the joins lose and double nothing: total spend matches staging, and every sales week is kept.

To rebuild: `pip install -r requirements.txt`, then `cd dbt` and `dbt build --profiles-dir .`

### ROAS and CPA by campaign
- Computed as ratios of sums, then reproduced in pandas ([02_pandas_analysis.ipynb](notebooks/02_pandas_analysis.ipynb)) with a validated merge. The numbers match.
- Campaign 1226 has the highest ROAS (4.34) on only $3.4k spend; campaign 1114 has a lower ROAS (2.97) but $184k revenue on $62k spend.
- Average ROAS is not marginal ROAS, so this ranking alone can't say where to move budget. That's what the MMM is for.

### Next
Channel-level ROAS from `mart_weekly_mmm`, then the marketing mix model.

## Roadmap

- [x] Project setup
- [x] Data generation
- [x] SQL analysis: data quality checks, ROAS and CPA by campaign
- [x] dbt pipeline: staging models, data tests, weekly MMM table
- [ ] Exploratory analysis (pandas): ROAS reproduced, channel trends next
- [ ] Marketing mix model
- [ ] Streamlit app
- [ ] Tableau dashboard
- [ ] Findings and recommendations