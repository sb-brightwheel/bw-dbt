{{
    config(
        materialized='table',
        dist='salesforce_lead_id'
    )
}}

/*  Insert brief description of what this query produces and why it was written.  */

select
	id as salesforce_lead_id
    ,first_name as lead_first_name
    ,last_name as lead_last_name
    ,title as lead_job_title
    ,company as lead_company
    ,street as street_address  --  are the following address related fields lead specific or company specific?
    ,city
    ,state
    ,postal_code
    ,country
    ,phone as lead_phone
    ,mobile_phone as lead_mobile_phone
    ,email as lead_email
    ,website as lead_company_website
    ,lead_source
    ,status as lead_status
    ,is_converted
    ,created_date::timestamp as lead_created_timestamp  --  convert timezones (ie UTC -> US/Pacific)?
    ,last_modified_date::timestamp as lead_last_modified_timestamp
    ,last_activity_date::date as lead_last_activity_date
    ,last_viewed_date::date as lead_last_viewed_date
    ,last_referenced_date::date as lead_last_referenced_date
    ,email_bounced_reason
    ,email_bounced_date::date
    ,outreach_stage_c as outreach_stage
    ,current_enrollment_c as current_enrollment
    ,capacity_c as capacity
    ,lead_source_last_updated_c::date as lead_source_last_updated_date
    ,brightwheel_school_uuid_c as brightwheel_school_uuid
from {{ source('brightwheel_exercise','salesforce_leads') }} 