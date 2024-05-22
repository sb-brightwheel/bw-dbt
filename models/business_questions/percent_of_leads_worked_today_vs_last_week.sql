{{
    config(
        materialized='view'
    )
}}

/*  This query aims to answer the following question: What percentage of existing leads are being worked today / last week?  */

with percent_of_leads_worked_today as (
    select
        count(distinct case when outreach_stage_c = 'Working' then id end) as working_leads_count
        ,count(distinct id) as total_leads_count
        ,working_leads_count / total_leads_count as percent_of_leads_worked_today
    from {{ ref('salesforce_leads_snapshot') }}
    where dbt_valid_to is null
),
percent_of_leads_worked_last_week as (
    select
        count(distinct case when outreach_stage_c = 'Working' then id end) as working_leads_count
        ,count(distinct id) as total_leads_count
        ,working_leads_count / total_leads_count as percent_of_leads_worked_last_week
    from {{ ref('salesforce_leads_snapshot') }}
    where date_trunc('week', dbt_valid_to) = date_trunc('week', dateadd('day', -7, current_date))
)
select
    today.percent_of_leads_worked_today
    ,last_week.percent_of_leads_worked_last_week
from percent_of_leads_worked_today today
cross join percent_of_leads_worked_last_week last_week 