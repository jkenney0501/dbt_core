-- transform the raw scd model
-- some of this logic does repeat but....
-- This will turn into a dimension directly from here as there is no more work to be done on it

with scd_listings_transformed as(
    select  
        id as listing_id,
        listing_url,
        name,
        room_type,
        case when minimum_nights = 0 then 1 end as minimum_nights,
        host_id,
        replace(price, '$') ::number(10,2) as price,
        created_at,
        dbt_updated_at as updated_at,
        dbt_valid_from as start_date,
        dbt_valid_to as end_date,
        case when dbt_valid_to is null then 1 else 0 end as is_current
    from {{ ref('scd_raw_listings') }}
)

select *
from scd_listings_transformed