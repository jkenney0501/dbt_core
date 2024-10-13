-- stage reviews

with reviews as(
    select *
    from {{ source('airbnb', 'raw_reviews') }}
        
)

select 
    listing_id,
    date::datetime as review_date,
    reviewer_name,
    comments as review_text,
    sentiment as review_sentiment
from 
    reviews