-- creates a dataset where the that captures whether or not eb moon was full when the review was made

{{ 
    config(
        materialized = 'table',
        schema='marts'
) }}


WITH fct_reviews AS (

        SELECT * 
        FROM {{ ref('fct_reviews') }}

),

full_moon_dates AS (

        SELECT * 
        FROM AIRBNB.DEV_SEED_DATA.SEED_FULL_MOON_DATES -- this needs replaced as a ref but dbt would not recognize the schema for whatever reason.

)

SELECT
    r.*,
        CASE
            WHEN fm.full_moon_date IS NULL THEN 'not full moon'
        ELSE 'full moon'
    END AS is_full_moon
FROM
 fct_reviews
 r
 LEFT JOIN full_moon_dates
 fm
 ON (TO_DATE(r.review_date) = DATEADD(DAY, 1, fm.full_moon_date))