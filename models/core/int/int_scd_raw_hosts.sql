-- transform the raw scd model
-- This will turn into a dimension directly from here as there is no more work to be done on it


with scd_hosts_transformed as(

    select  
        id as host_id,
        name,
        is_superhost,
        created_at,
        dbt_updated_at as updated_at,
        dbt_valid_from as start_date,
        dbt_valid_to as end_date,
        case when dbt_valid_to is null then 1 else 0 end as is_current
    from 
        {{ ref('scd_raw_hosts') }}
)

select *
from scd_hosts_transformed