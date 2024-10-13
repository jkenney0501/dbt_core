-- prod host dimension

with dim_host_final as(

    select *
    from
        {{ ref('int_dim_host_clean') }}
)

select *
from 
    dim_host_final