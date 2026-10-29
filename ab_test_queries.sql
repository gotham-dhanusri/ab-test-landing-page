
-- conversion rate by group
SELECT "group",
COUNT(*) AS users,
SUM(converted) AS conversions,
ROUND(100.0 * SUM(converted) / COUNT(*), 3) AS conversion_rate
FROM ab_data
GROUP BY "group";

-- coverted vs not converted by page
SELECT landing_page,
SUM(CASE WHEN converted = 1 THEN 1 ELSE 0 END) AS converted_users,
SUM(CASE WHEN converted = 0 THEN 1 ELSE 0 END) AS not_converted
FROM ab_data
GROUP BY landind_page;

-- daily conversion rate by group
WITH daily AS (
SELECT date,"group",
COUNT(*) AS users,
SUM(converted) AS conv
FROM ab_data
GROUP BY date,"group"
)
SELECT date,"group",users,
ROUND(100.0 * conv / users,2) as rate
FROM daily
ORDER BY date,"group";
