-- transform the raw scd model
-- some of this logic does repeat but....
-- This will turn into a dimension directly from here as there is no more work to be done on it


{% snapshot scd_raw_hosts %}

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
    from {{ source('airbnb', 'raw_hosts')}}

{% endsnapshot %}