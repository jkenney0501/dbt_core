-- prod listings table

with dim_listings_final as(

    select *
    from 
        {{ ref('int_dim_listings_clean') }}
)

select *
from 
    dim_listings_final