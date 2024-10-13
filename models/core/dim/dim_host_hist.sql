-- prod host hsitory table
with dim_host_hist as(

    select *
    from    
        {{ ref('int_scd_raw_hosts') }}
)

select *
from 
    dim_host_hist