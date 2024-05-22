{{
    config(
        materialized='table'
    )
}}

/*  Insert brief description of what this query produces and why it was written.  */

select
    'Source 1' as source
    ,'Unkown' as accepts_financial_aid
    ,'Unknown' as ages_served
    ,null::float as capacity
    ,expiration_date::date as certificate_expiration_date
    ,null as city  --  could pull city out of address column
    ,address as address1
    ,null as address2
    ,name as company
    ,phone as phone
    ,phone2
    ,county
    ,'Unknown' as curriculum_type
    ,null as email
    ,split_part(primary_contact_name, ' ', 1) as first_name
    ,split_part(primary_contact_name, ' ', 2) as last_name
    ,'Uknown' as language  --  not sure if this is referring to spoken language, if so maybe could use address to reference a geo table and make an estimated guess based on the nations native language
    ,status as license_status
    ,first_issue_date::date as license_issued
    ,credential_number as license_number -- cannot cast to numeric data type with '-' in value ?
    ,null::date as license_renewed
    ,credential_type as license_type
    ,primary_contact_name as licensee_name
    ,null::float as max_age
    ,null::float as min_age
    ,null as operator
    ,null as provider_id
    ,null as schedule
    ,state
    ,primary_contact_role as title
    ,null as website_address
    ,regexp_extract(address, '(\d{5})$') as zip  --  '\d{5}' matches 5 digits, '$' denotes the end of the string
    ,null as facility_type
from {{ source('brightwheel_exercise','source1_file') }} 