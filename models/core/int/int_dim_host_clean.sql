-- clean logic prep for dim hosts
with dim_host_clean as(

    select *
    from 
        {{ ref('stg_raw_hosts') }}

)

select 
    host_id,
    nvl(host_name, 'anonymous') as host_name,
    is_superhost,
    created_at,
    updated_at
from dim_host_clean