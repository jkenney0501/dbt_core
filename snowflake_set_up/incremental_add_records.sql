-- add records to capture increments


-- view this listing id using below:
select *
from  AIRBNB.RAW.RAW_REVIEWS
where listing_id = 3176


-- lets add two reviews to it.
-- insert new records into raw table
insert into  AIRBNB.RAW.RAW_REVIEWS (id, date, reviewer_name, comments, sentiment)
values (3176, current_timestamp, 'Zoltan', 'Super great stay all the way!!!', 'positive'),
       (3176, current_timestamp, 'James',  'meg uber awesome!', 'positive')


-- check new records in the raw table
-- should only be 2 rows returned, execute with dbt run
select *
from AIRBNB.RAW.RAW_REVIEWS
where listing_id = 3176