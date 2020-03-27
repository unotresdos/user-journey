-- 1.1 Number of campaigns 
SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;
-- 1.1 Number of sources
SELECT COUNT(DISTINCT utm_source)
FROM page_visits;
-- 1.3 How source and campaign related
SELECT DISTINCT utm_campaign, utm_source
FROM page_visits
ORDER BY 2;

-- 2. Pages of the website
SELECT DISTINCT page_name
FROM page_visits;

-- 3. First touches for campaigns
WITH first_touch AS (
    SELECT user_id,
       MIN(timestamp) AS 'first_touch_at'
    FROM page_visits
    GROUP BY user_id)
SELECT utm_source, utm_campaign, COUNT(*) AS number_of_ft
FROM first_touch AS 'ft'
JOIN page_visits AS 'pv'
   ON ft.user_id = pv.user_id
   AND ft.first_touch_at = pv.timestamp
GROUP BY utm_campaign, utm_source
ORDER BY 3 DESC;

-- 4. Last touches for campaigns
WITH last_touch AS (
    SELECT user_id,
       MAX(timestamp) AS 'last_touch_at'
    FROM page_visits
    GROUP BY user_id)
SELECT utm_source, utm_campaign, COUNT(*) AS number_of_lt
FROM last_touch AS 'lt'
JOIN page_visits AS 'pv'
   ON lt.user_id = pv.user_id
   AND lt.last_touch_at = pv.timestamp
GROUP BY utm_campaign, utm_source
ORDER BY 3 DESC;

-- 5. Number of purchases
SELECT COUNT (DISTINCT user_id) AS number_of_purchases
FROM page_visits
WHERE page_name = '4 - purchase';

-- 6. Number of purchases for each campaign  
WITH last_touch AS (
    SELECT user_id,
       MAX(timestamp) AS 'last_touch_at'
    FROM page_visits
    GROUP BY user_id)
SELECT utm_source, utm_campaign, COUNT(*) AS number_of_purchases
FROM last_touch AS 'lt'
JOIN page_visits AS 'pv'
   ON lt.user_id = pv.user_id
   AND lt.last_touch_at = pv.timestamp
WHERE page_name = '4 - purchase'
GROUP BY utm_campaign, utm_source
ORDER BY 3 DESC;

-- 7. 

