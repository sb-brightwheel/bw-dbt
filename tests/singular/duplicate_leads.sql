/*  Invoke this test with `dbt test`. To store the results of this test, call the command with the `--store-failures` flag.
    
    This test checks if there are any duplicate leads in our  */

select
    phone||address1 as unique_lead_identifier
    ,count(*) as lead_count
from {{ ref('int_all_sources_flattened') }}
group by unique_lead_identifier
having lead_count > 1 