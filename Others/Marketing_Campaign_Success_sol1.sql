/*
Marketing Campaign Success [Advanced]
You have a table of in-app purchases by user. Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases. Find the number of users that made additional in-app purchases due to the success of the marketing campaign.
The marketing campaign doesn't start until one day after the initial in-app purchase so users that make multiple purchases on the same day do not count, nor do we count users that make only the same purchases over time.


*/

-- Problem
-- table: marketing_campaign 
    -- in-app purchases by users
-- expected output: the number of users - additional in-app purchased 
    -- purchases due to marketing campaign
-- requirements
    -- first purchase - not count
    -- multiple purchases on the same day - not count
    -- multiple purchases on the same products - not count
-- Scenario
    -- single purchase on a single product on the first day - Not eligible
    -- multipl purchase on a single product on the first day - Not eligible
    -- multiple purchases on multiple products on the first day - Not eligible
    -- multiple purchases on single product on multiple days - Not eligible
    -- multiple purchases on multiple products on multiple days Eligible


WITH users (user_id, eligible) AS (
    SELECT user_id
    , case when MIN(created_at) OVER (PARTITION BY user_id) <> MIN(created_at) OVER (PARTITION BY user_id, product_id) THEN 1 ELSE 0 END as eligible
    FROM marketing_campaign
)
SELECT count(distinct(user_id))
FROM users
WHERE eligible = 1



