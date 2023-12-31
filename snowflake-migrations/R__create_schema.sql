USE ROLE {{ENV}}_SYSADMIN;
CREATE SCHEMA IF NOT EXISTS {{ENV}}_{{TeamName}}_CURATED_DB.COMMON WITH MANAGED ACCESS;
CREATE SCHEMA IF NOT EXISTS {{ENV}}_{{TeamName}}_STG_DB.COMMON WITH MANAGED ACCESS;
USE ROLE SYSADMIN;
CREATE TABLE {{ENV}}_{{TeamName}}_DB.COMMON.SampleTable
(
   FIRST_NAME VARCHAR
  ,LAST_NAME VARCHAR
);