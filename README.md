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

Python, DuckDB (SQL), pandas, NumPy, scikit-learn, statsmodels, Streamlit, Tableau Public, Git

## Progress so far

### Data quality checks ([01_sql_analysis.ipynb](notebooks/01_sql_analysis.ipynb))
- Four tables, 2024-01-01 to 2025-12-28: `campaigns` (229 campaigns), `daily_performance` (one row per campaign per day), `weekly_sales` (104 weeks), `promotions` (12 promo weeks).
- **Duplicates:** campaign 1137 had 14 days (2025-03-03 to 03-16) duplicated as exact copies, which would double-count its spend and revenue. Fixed with a `daily_clean` view (13,062 to 13,048 rows); the raw table is untouched.
- **Clean:** 0 orphan campaign IDs, no impossible values (negative spend, clicks above impressions), both weekly tables start on Monday.
- `promotions` lists promo weeks only, so it must be LEFT JOINed to `weekly_sales` or non-promo weeks drop out.

### ROAS and CPA by campaign
- Computed as ratios of sums, then reproduced in pandas ([02_pandas_analysis.ipynb](notebooks/02_pandas_analysis.ipynb)) with a validated merge. The numbers match.
- Campaign 1226 has the highest ROAS (4.34) on only $3.4k spend; campaign 1114 has a lower ROAS (2.97) but $184k revenue on $62k spend.
- Average ROAS is not marginal ROAS, so this ranking alone can't say where to move budget. That's what the MMM is for.

### Next
Roll daily data up to Monday-start weeks and join to sales and promotions, which gives the MMM's input table. Then channel-level ROAS.

## Roadmap

- [x] Project setup
- [x] Data generation
- [x] SQL analysis: data quality checks, ROAS and CPA by campaign
- [ ] Exploratory analysis (pandas): ROAS reproduced, trends next
- [ ] Marketing mix model
- [ ] Streamlit app
- [ ] Tableau dashboard
- [ ] Findings and recommendations