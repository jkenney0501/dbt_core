
-- fact table for reviews
-- model is incremental

{{
    config(
        materialized ='incremental',
        on_schema_change='fail',
        schema = 'int_incrementals'
    )
}}


with fact_reviews_cleaned as(

    select *
    from
        {{ ref('stg_raw_reviews') }}

)

select 
{{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', ' reviewer_name', ' review_text']) }} as listing_surrogate_key,
*
from fact_reviews_cleaned
where review_text is not null
    -- incremental macro to get only new records by using max review date from previus run to compare to current
    {% if is_incremental() %}

        and review_date > (select max(review_date) from {{ this}} )

    {% endif %}