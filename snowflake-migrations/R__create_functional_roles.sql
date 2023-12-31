USE ROLE SECURITYADMIN;
CREATE ROLE IF NOT EXISTS {{ENV}}_{{TeamName}}_ADMIN_FR;
GRANT ROLE {{ENV}}_{{TeamName}}_ADMIN_FR TO ROLE {{ENV}}_SYSADMIN;
CREATE ROLE IF NOT EXISTS {{ENV}}_{{TeamName}}_ANALYST_FR;
GRANT ROLE {{ENV}}_{{TeamName}}_ANALYST_FR TO ROLE {{ENV}}_SYSADMIN;
CREATE ROLE IF NOT EXISTS {{ENV}}_{{TeamName}}_DATABRICKS_FR;
GRANT ROLE {{ENV}}_{{TeamName}}_DATABRICKS_FR TO ROLE {{ENV}}_SYSADMIN;
CREATE ROLE IF NOT EXISTS {{ENV}}_{{TeamName}}_ENGINEER_FR;
GRANT ROLE {{ENV}}_{{TeamName}}_ENGINEER_FR TO ROLE {{ENV}}_SYSADMIN;
USE ROLE SYSADMIN;
