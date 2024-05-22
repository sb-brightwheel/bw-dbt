{{
    config(
        materialized='table'
    )
}}

/*  Insert brief description of what this query produces and why it was written.  */

select
    'Source 3' as source
    ,'Unknown' as accepts_financial_aid
    /*  the order of each case scenario matters - the first scenario that evaluates as true will be
        returned as the value for the lower and upper ages served boundary  */
    ,case
        when infant = 'Y' then '0 - '
        when toddler = 'Y' then '1 - '
        when preschool = 'Y' then '2 - '
        when school = 'Y' then '5 - '
        else 'Unknown'
    end as ages_served_lower_bound
    ,case
        when school = 'Y' then '5 years+'
        when preschool = 'Y' then '4 years'
        when toddler = 'Y' then '2 years'
        when infant = 'Y' then '1 year'
        else 'Unknown'
    end as ages_served_upper_bound
    ,ages_served_lower_bound||ages_served_upper_bound as ages_served
    ,capacity
    ,null::date as certificate_expiration_date
    ,city
    ,address||' '||city||' '||state||', '||zip as address1
    ,null as address2
    ,operation_name as company
    ,phone as phone1
    ,null as phone2
    ,county
    ,'Unknown' as curriculum_type
    ,email_address as email
    ,null as first_name
    ,null as last_name
    ,'Uknown' as language
    ,status as license_status
    ,issue_date as license_issued
    ,operation as license_number
    ,null::date as license_renewed -- might be same thing as issued date, would want to check that assumption
    ,type as license_type
    ,operation_name as licensee_name
    ,null::float as max_age -- in the interest of time skipping these columns, could potentially infer from the ages served column above
    ,null::float as min_age
    ,null as provider_id
    ,null as schedule -- skipping in the interest of time but could leverage the week day columns to normalize a schedule
    ,state
    ,null as title
    ,null as website_address
    ,zip
    ,type as facility_type
from {{ source('brightwheel_exercise','source3_file') }} 