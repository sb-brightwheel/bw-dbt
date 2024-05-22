# Brightwheel dbt Project

Welcome to the Brightwheel dbt project! This project has been designed to transform and standardize mock data files to help answer business questions. The repository includes dbt models staged in such a way to process raw data and generate clean, reliable datasets for analytics and reporting. This repository was organized in ~ 2 hours time - please refer to the Long Term Considerations section for for ideas & intentions for longer term design.

## Repository Structure

The repository is organized as follows:

- **models/**: Contains the dbt models.
  - **_sources/**: YAML file outlining raw data sources referenced in this project.
  - **business_questions/**: Directory with queries to answer business questions, and a scratch file with pseudo-code to answer business questions.
  - **intermediate/**: Models that perform further transformations on staged data.
  - **staging/**: Models that process and standardize raw source tables.
- **snapshots/**: Contains special dbt models that tracks changes in data over time, following Type 2 SCD patterns.
- **tests/**: Custom singular tests to ensure data quality.

## Tradeoffs

- Incremental strategies were not leveraged in model configurations. Having a deeper understanding of how files are ingested into the Warehouse could potentially pave the way for configuring expensive models to build incrementally by only adding net new records and overriding existing records where applicable. This strategy can greatly reduce model run times, especially for models that reference large data sets.

- Testing in this project is sparse. Without a deeper understanding of assertions to make against the underlying data sets, testing is hard implement. Singular tests were written to demonstrate understanding of executing these types of tests. Generic tests that dbt ships with out of the box could also be implemented in models.yml file(s), but again, assertions were not obvious in this exercise. Future versions of this project could include generic tests in mission-critical models, testings for things like columns not containing null values, column uniqueness, accepted values for enum columns, relationships between models, etc. 

## Long Term Considerations

Table optimization:

- With each file being 100GB in size, staging models should leverage Redshift warehouse architecture to it's advantage through proper distribution and sort key strategies. These keys will optimize how and where data is stored in Redshift cluster and greatly reduce the amount time, and of data scanned during query execution.

- To account for changing file schemas, incremental models could be configured with `on_schema_change='append_new_columns'` to append new columns to the existing destination table. Snapshot models were written with `select *` in mind to achieve the same behavior.

Making leads available for outreach:

- To make leads available for outreach, their information will need to be loaded into a CRM platform (ie Salesforce). There are a number of existing Reverse ETL tools/providers in the world today, but this could also be explored with Python and Salesforce's Bulk Upload API.

Data Enrichment:

- Work with a data provider such as ZoomInfo and set up a enrichment process where internal lead data is shared and enriched with new or missing information. New lead data pipelines could also be set up working with data providers to drop parquet files into an S3 bucket in the same region as Redshift cluster (to minimize data transport costs) for staging and copying over to Redshift, through scheduled COPY queries or AWS Glue.
