{{
    config(
        materialized='table'
    )
}}

/*  Insert brief description of what this query produces and why it was written. The assumed desired
    use of this model is it will be used for loading prospective leads into Salesforce.  */

select
    source
    ,accepts_financial_aid
    ,ages_served
    ,capacity
    ,certificate_expiration_date
    ,city
    ,address1
    ,address2
    ,company
    ,phone
    ,phone2
    ,county
    ,curriculum_type
    ,email
    ,first_name
    ,last_name
    ,language
    ,license_status
    ,license_issued
    ,license_number
    ,license_renewed
    ,license_type
    ,licensee_name
    ,max_age
    ,min_age
    ,operator
    ,provider_id
    ,schedule
    ,state
    ,title
    ,website_address
    ,zip
    ,facility_type
from {{ ref('stg_source1__entities') }}
union all  --  more performant than a regular union, helps when working with large data sets BUT might result in duplicate entities in a situation where the same entity exists in more than one source file
select
    source
    ,accepts_financial_aid
    ,ages_served
    ,capacity
    ,certificate_expiration_date
    ,city
    ,address1
    ,address2
    ,company
    ,phone
    ,phone2
    ,county
    ,curriculum_type
    ,email
    ,first_name
    ,last_name
    ,language
    ,license_status
    ,license_issued
    ,license_number
    ,license_renewed
    ,license_type
    ,licensee_name
    ,max_age
    ,min_age
    ,operator
    ,provider_id
    ,schedule
    ,state
    ,title
    ,website_address
    ,zip
    ,facility_type
from {{ ref('stg_source2__entities') }}
union all
select
    source
    ,accepts_financial_aid
    ,ages_served
    ,capacity
    ,certificate_expiration_date
    ,city
    ,address1
    ,address2
    ,company
    ,phone
    ,phone2
    ,county
    ,curriculum_type
    ,email
    ,first_name
    ,last_name
    ,language
    ,license_status
    ,license_issued
    ,license_number
    ,license_renewed
    ,license_type
    ,licensee_name
    ,max_age
    ,min_age
    ,operator
    ,provider_id
    ,schedule
    ,state
    ,title
    ,website_address
    ,zip
    ,facility_type
from {{ ref('stg_source3__entities') }} 