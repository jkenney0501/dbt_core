
-- stage raw listings does have 0 for some results so this is to fix that
select *
from 
    {{ ref('int_dim_listings_clean') }}
where minimum_nights < 1