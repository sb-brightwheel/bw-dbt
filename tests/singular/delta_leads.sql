/*  use get_columns_in_relation macro to grab all column names from source, and store list of column names to later pass into surrogate key macro and generate an md5 row hash  */

{%- set columns = get_columns_in_relation(ref('int_all_sources_flattened')) -%}

{% set column_names = columns|map(attribute='name')|list %}

/*  Invoke this test with `dbt test`. To store the results of this test, call the command with the `--store-failures` flag.
    
    This test returns unique lead identifiers that have multiple rows, indicating one unique leads has more than one record with varying dimension values  */

with unique_lead_hash_records as (
    select
        phone||address1 as unique_lead_identifier
        ,{{ dbt_utils.generate_surrogate_key( column_names )}} as hash_id
    from {{ ref('int_all_sources_flattened') }}
)
select
    unique_lead_identifier
    ,count(distinct hash_id) as record_count
from unique_lead_hash_records
group by unique_lead_identifier
having record_count > 1 