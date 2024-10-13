-- prod listing hsitory table
with dim_listings_hist as(

    select *
    from    
        {{ ref('int_scd_raw_listings') }}
)

select *
from 
    dim_listings_hist