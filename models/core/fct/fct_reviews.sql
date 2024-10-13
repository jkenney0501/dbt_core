-- prod fact table
{{
    config(
        materialized = 'table'
    )
}}


with final_fact as(

    select *
    from
        {{ ref('int_fct_reviews_clean')}}

)

select *
from final_fact