{% snapshot salesforce_leads_snapshot %}  

{{
  config(
    target_schema='snapshots',
    strategy='timestamp',
    unique_key='id',
    updated_at='last_modified_date'
  )
}}

/*  This snapshot strategy will create new snapshot records whenever the value of any columns in the source table change for a specific id.
    This strategy might cause performance issues on large datasets - to optimize, check a smaller list of of columns that the business cares most about tracking changes for.  */

select
    *
    ,street||' '||city||' '||state||', '||postal_code||' '||country as full_address
    ,{{ dbt_utils.generate_surrogate_key(['phone', 'full_address']) }} as id
from {{ source('brightwheel_exercise','salesforce_leads') }}
where is_deleted is not true

{% endsnapshot %} 