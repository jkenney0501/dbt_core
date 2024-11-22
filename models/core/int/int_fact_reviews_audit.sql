
-- pulls only data that is current so we dont rebuild the table every time and have 3 tables with the same data
-- this table should be truncatd daily or scheduled to truncate on a job even
with audit_table as(

    select *
    from 
        {{ ref('stg_raw_reviews') }}
    --where date(review_date) = date(current_date())

)

select *
from audit_table