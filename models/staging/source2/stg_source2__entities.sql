2{{
    config(
        materialized='table'
    )
}}

/*  Insert brief description of what this query produces and why it was written.  */

select
    'Source 2' as source
    ,case
        when accepts_subsidy = 'Accepts Subsidy' then 'True'
        else 'False'
    end as accepts_financial_aid
    ,ages_accepted1||' | '||aa2||' | '||aa3||' | '||aa4 as ages_served_raw_list
    /*  the order of each case scenario matters - the first scenario that evaluates as true will be
        returned as the value for the lower and upper ages served boundary  */
    ,case
        when ages_served_raw_list ilike '%infants%' then '0 - '
        when ages_served_raw_list ilike '%toddlers%' then '1 - '
        when ages_served_raw_list ilike '%preschool%' then '2 - '
        when ages_served_raw_list ilike '%school-age%' then '5 - '
        else 'Unknown'
    end as ages_served_lower_bound
    ,case
        when ages_served_raw_list ilike '%school-age%' then '5 years+'
        when ages_served_raw_list ilike '%preschool%' then '4 years'
        when ages_served_raw_list ilike '%toddlers%' then '2 years'
        when ages_served_raw_list ilike '%infants%' then '1 year'
        else 'Unknown'
    end as ages_served_upper_bound
    ,ages_served_lower_bound||ages_served_upper_bound as ages_served
    ,total_cap as capacity
    ,null::date as certificate_expiration_date
    ,city
    ,address1||' '||city||' '||state||', '||zip as address1
    ,address2 -- afraid to concat city state and zip to address2 because those are probably specific to the primary address
    ,company
    ,phone
    ,null as phone2
    ,null as county -- maybe infer this from a geo lookup table based on zip and state?
    ,'Unknown' as curriculum_type
    ,email
    ,split_part(primary_caregiver, ' ', 1) as first_name
    ,split_part(primary_caregiver, ' ', 2) as last_name
    ,'Uknown' as language
    ,'Unknown' as license_status
    ,replace(license_monitoring_since, 'Monitoring since', '')::date as license_issued
    ,regexp_extract(type_license, '( - K\d+)') as license_number -- regexp pattern searches for a number of digits that follow the pattern ' - K'
    ,null::date as license_renewed
    ,split_part(type_license, ' - K', 1) as license_type -- extracts any sequence of characters preceding the ' - K' string pattern
    ,first_name||' '||last_name as licensee_name
    ,null::float as max_age -- in the interest of time skipping these columns, could potentially infer from the ages served column above
    ,null::float as min_age
    ,null as provider_id
    ,null as schedule -- skipping in the interest of time but could leverage the week day columns to normalize a schedule
    ,state
    ,split_part(primary_caregiver, '\n', 2) as title
    ,null as website_address
    ,zip
    ,null as facility_type
from {{ source('brightwheel_exercise','source2_file')}} 