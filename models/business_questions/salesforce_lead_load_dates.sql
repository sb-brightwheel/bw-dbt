-- When was this lead loaded into salesforce?
select
    salesforce_lead_id
    ,lead_created_date
from {{ ref('stg_salesforce__leads')}} 