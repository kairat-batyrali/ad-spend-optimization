# Ad Spend Optimization

**Status: in progress**

## The brief

A retail client spent $2M on advertising last year across Google, Meta, TikTok, and YouTube. They want to know which channels actually drive revenue, where spend has hit diminishing returns, and how to reallocate next year's budget.

## Approach

1. **Data:** a Python script generates two years of synthetic weekly campaign data with known patterns built in, so the analysis can be checked against ground truth at the end.
2. **SQL (DuckDB):** data quality checks and core marketing KPIs (ROAS, CPA, CTR, CPM), plus creative fatigue and segment analysis.
3. **Exploratory analysis (pandas):** trends over time and follow-ups on what the SQL surfaced.
4. **Marketing mix model:** estimates each channel's response curve to measure diminishing returns, validated on a held-out time period.
5. **Streamlit app:** KPI overview and a budget reallocation tool driven by the model.
6. **Tableau Public dashboard:** the weekly view a client would check.
7. **Findings:** recommendations, plus an honest comparison of what the analysis caught and missed against the built-in patterns.

## Tools

Python, DuckDB (SQL), pandas, NumPy, scikit-learn, statsmodels, Streamlit, Tableau Public, Git

## Roadmap

- [x] Project setup
- [ ] Data generation
- [ ] SQL analysis
- [ ] Exploratory analysis
- [ ] Marketing mix model
- [ ] Streamlit app
- [ ] Tableau dashboard
- [ ] Findings and recommendations