# Data dictionary

Synthetic data for a fictional Canadian retailer, covering January 1, 2024 to
December 28, 2025 (104 weeks). All amounts are in CAD. Weeks start on Monday.

## campaigns.csv
One row per ad campaign.

| Column | Description |
|---|---|
| campaign_id | Unique campaign ID |
| campaign_name | Naming convention: CHANNEL_REGION[_LANGUAGE]_STARTDATE_CREATIVE |
| channel | Google Search, Meta, TikTok, or YouTube |
| region | Ontario, Quebec, British Columbia, Alberta, or Atlantic |
| language | Creative language (EN or FR) |
| creative_type | Text, Image, Carousel, or Video |
| objective | Campaign objective set in the ad platform |
| start_date | First day of the campaign |
| end_date | Last day of the campaign |

## daily_performance.csv
One row per campaign per day with spend, as exported from the ad platforms.

| Column | Description |
|---|---|
| date | Day |
| campaign_id | Joins to campaigns.csv |
| spend | Amount spent that day |
| impressions | Times the ad was shown |
| clicks | Clicks on the ad |
| conversions | Purchases the ad platform attributes to the campaign |
| revenue | Revenue the ad platform attributes to the campaign |

## weekly_sales.csv
The client's total sales per week, across all channels (online and in store),
from the client's own records.

| Column | Description |
|---|---|
| week_start | Monday of the week |
| total_sales | Total sales that week |

## promotions.csv
The client's promotional calendar.

| Column | Description |
|---|---|
| week_start | Monday of the promo week |
| promo_name | Name of the promotion |
| discount_pct | Sitewide discount, in percent |
