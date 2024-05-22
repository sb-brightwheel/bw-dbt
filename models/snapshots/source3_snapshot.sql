{% snapshot source3_snapshot %}  

{{
  config(
    target_schema='snapshots',
    strategy='check',
    unique_key='id',
    check_cols='all'
  )
}}

/*  This snapshot strategy will create new snapshot records whenever the value of any columns in the source table change for a specific id.
    This strategy might cause performance issues on large datasets - to optimize, check a smaller list of of columns that the business cares most about tracking changes for.  */

select
    'Source 3' as source
    ,*
    ,address||' '||city||' '||state||', '||zip||' '||county as full_address
    ,{{ dbt_utils.generate_surrogate_key(['phone', 'full_address']) }} as id
from {{ source('brightwheel_exercise','source3_file') }}

{% endsnapshot %} 