-- prod host dimension
-- chnage to pull from scd where is_current =1
with dim_host_final as(

    select *
    from
        {{ ref('int_dim_host_clean') }}
)

select *
from 
    dim_host_final