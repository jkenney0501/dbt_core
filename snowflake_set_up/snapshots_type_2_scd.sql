-- snapshots changes that we add in snowflake 
-- use command: dbt snapshot to materilize in snowflake
-- using raw_listings and raw_hosts as examples with two different stratgeies- timestamp and check

----- LISTINGS ------
-- update a row in the raw table to capture changesAIRBNB.RAW.RAW_LISTINGS
select * from AIRBNB.RAW.RAW_LISTINGS
where id = 3176

-- update minimum nights to 30, run dbt snpshot again after update
update AIRBNB.RAW.RAW_LISTINGS
set minimum_nights = 30, updated_at = current_timestamp()
where id = 3176

-- run dbt snapshot to materialize 

-- check here to see updates after running dbt snapshot
select *
from AIRBNB.DEV_SNAPSHOTS.SCD_RAW_LISTINGS
where id = 3176


-- apply trasnformations for int model
select  
    id as listing_id,
    listing_url,
    name,
    room_type,
    minimum_nights,
    host_id,
    replace(price, '$') ::number(10,2) as price,
    created_at,
    dbt_updated_at as updated_at,
    dbt_valid_from as start_date,
    dbt_valid_to as end_date,
    case when dbt_valid_to is null then 1 else 0 end as is_current
from AIRBNB.DEV_SNAPSHOTS.SCD_RAW_LISTINGS  -- use a referenfce here in the model , this is used in snf for dev


-- check int model after transformations applied
select *
from AIRBNB.DEV.INT_SCD_RAW_LISTINGS
where listing_id = 3176


--**** ALL GOOD, DO THE SAME FOR HOSTS ****


----- Host -----
-- check host data
select *
from AIRBNB.RAW.RAW_HOSTS

-- modify host data, change the name from Annette to Anne
update AIRBNB.RAW.RAW_HOSTS
set name = 'Anne', updated_at = current_timestamp()
where id = 1581


-- check data 
select *
from AIRBNB.RAW.RAW_HOSTS
where id = 1581

-- run dbt snapshot to materialize 

-- check snapshots host schema, there are now two rows for this id
-- move this model to intermediate with transformations happening there
select *
from AIRBNB.DEV_SNAPSHOTS.SCD_RAW_HOSTS
where id = 1581


-- apply transformatiopns to intermediate model and create the model in dbt, repalce the fqn with a ref after model is run
select  
    id as host_id,
    name,
    is_superhost,
    host_id,
    created_at,
    dbt_updated_at as updated_at,
    dbt_valid_from as start_date,
    dbt_valid_to as end_date,
    case when dbt_valid_to is null then 1 else 0 end as is_current
from AIRBNB.DEV_SNAPSHOTS.SCD_RAW_HOSTS

-- check intermediate model after transfoprmations
select *
from AIRBNB.DEV.INT_SCD_RAW_HOSTS
where host_id = 1581