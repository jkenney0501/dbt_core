-- scd type 2 for listing using timestamp strategy
-- this will materialize as a atble in the dev_snapshots schema
-- from here, create am intermediate model to alter the and alias the dbt start/end columns and add an is_current flag
-- after first run, make a chnage to a specific row 

{% snapshot scd_raw_listings %}

{{
    config(
        target_schema='dev_snapshots',
        unique_key='id',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=True 
    )
}}

    select *
    from 
        {{ source('airbnb', 'raw_listings') }}

{% endsnapshot %}