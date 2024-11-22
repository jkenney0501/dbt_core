-- intermediate model to clean to prep for the dim listings table
with dim_listings_clean as(

    select *
    from 
        {{ ref('stg_raw_listings') }}

)

select 
    listing_id,
    listing_name,
    room_type,
    case
        when minimum_nights = 0 then 1
        else minimum_nights
    end as minimum_nights,
    host_id,
    replace(price_str, '$') ::number(10,2) as price,
    created_at,
    updated_at
from 
    dim_listings_clean