

-- Create DATA_ANALYST_WH_S full access role
USE ROLE SECURITYADMIN;
CREATE ROLE IF NOT EXISTS "__{{ENV}}_DATA_ANALYST_WH_S_FULL_AR";
GRANT MONITOR,USAGE,OPERATE,MODIFY ON WAREHOUSE "{{ENV}}_DATA_ANALYST_WH_S" TO ROLE "__{{ENV}}_DATA_ANALYST_WH_S_FULL_AR";


-- Create {{ENV}}_EDW_DATABRICKS_WH full access role
USE ROLE SECURITYADMIN;
CREATE ROLE IF NOT EXISTS "__{{ENV}}_{{TeamName}}_DATABRICKS_WH_FULL_AR";
GRANT MONITOR,USAGE,OPERATE,MODIFY ON WAREHOUSE "{{ENV}}_{{TeamName}}_DATABRICKS_WH" TO ROLE "__{{ENV}}_{{TeamName}}_DATABRICKS_WH_FULL_AR";
GRANT MONITOR,USAGE,OPERATE,MODIFY ON WAREHOUSE "{{ENV}}_{{TeamName}}_{{ProjectName}}_DATABRICKS_WH" TO ROLE "__{{ENV}}_{{TeamName}}_DATABRICKS_WH_FULL_AR";

-- Create EDW_ENGINEER_WH_S full access role
USE ROLE SECURITYADMIN;
CREATE ROLE IF NOT EXISTS "__{{ENV}}_{{TeamName}}_ENGINEER_WH_S_FULL_AR";
GRANT MONITOR,USAGE,OPERATE,MODIFY ON WAREHOUSE "{{ENV}}_{{TeamName}}_ENGINEER_WH_S" TO ROLE "__{{ENV}}_{{TeamName}}_ENGINEER_WH_S_FULL_AR";
GRANT MONITOR,USAGE,OPERATE,MODIFY ON WAREHOUSE "{{ENV}}_{{TeamName}}_{{ProjectName}}_ENGINEER_WH_S" TO ROLE "__{{ENV}}_{{TeamName}}_ENGINEER_WH_S_FULL_AR";

--usage on monitor roles
-- Create and Grant Privileges to Access Role __DATA_ANALYST_WH_S_UM_AR
USE ROLE SECURITYADMIN;
CREATE ROLE IF NOT EXISTS "__{{ENV}}_DATA_ANALYST_WH_S_UM_AR";
GRANT USAGE ON WAREHOUSE "{{ENV}}_DATA_ANALYST_WH_S" TO ROLE "__{{ENV}}_DATA_ANALYST_WH_S_UM_AR";
GRANT MONITOR ON WAREHOUSE "{{ENV}}_DATA_ANALYST_WH_S" TO ROLE "__{{ENV}}_DATA_ANALYST_WH_S_UM_AR";

-- Create and Grant Privileges to Access Role __{{ENV}}_EDW_DATABRICKS_WH_UM_AR
USE ROLE SECURITYADMIN;
CREATE ROLE IF NOT EXISTS "__{{ENV}}_{{TeamName}}_DATABRICKS_WH_UM_AR";
GRANT USAGE ON WAREHOUSE "{{ENV}}_{{TeamName}}_DATABRICKS_WH" TO ROLE "__{{ENV}}_{{TeamName}}_DATABRICKS_WH_UM_AR";
GRANT MONITOR ON WAREHOUSE "{{ENV}}_{{TeamName}}_DATABRICKS_WH" TO ROLE "__{{ENV}}_{{TeamName}}_DATABRICKS_WH_UM_AR";
GRANT MONITOR ON WAREHOUSE "{{ENV}}_{{TeamName}}_{{ProjectName}}_DATABRICKS_WH" TO ROLE "__{{ENV}}_{{TeamName}}_DATABRICKS_WH_UM_AR";

-- Create and Grant Privileges to Access Role __EDW_ENGINEER_WH_S_UM_AR
USE ROLE SECURITYADMIN;
CREATE ROLE IF NOT EXISTS "__{{ENV}}_{{TeamName}}_ENGINEER_WH_S_UM_AR";
GRANT USAGE ON WAREHOUSE "{{ENV}}_{{TeamName}}_ENGINEER_WH_S" TO ROLE "__{{ENV}}_{{TeamName}}_ENGINEER_WH_S_UM_AR";
GRANT MONITOR ON WAREHOUSE "{{ENV}}_{{TeamName}}_ENGINEER_WH_S" TO ROLE "__{{ENV}}_{{TeamName}}_ENGINEER_WH_S_UM_AR";
GRANT MONITOR ON WAREHOUSE "{{ENV}}_{{TeamName}}_{{ProjectName}}_ENGINEER_WH_S" TO ROLE "__{{ENV}}_{{TeamName}}_ENGINEER_WH_S_UM_AR";

USE ROLE SYSADMIN;

-