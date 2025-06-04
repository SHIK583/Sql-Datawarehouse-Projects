/*
========================================================
DDL Script: Create Bronze Tables
========================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables.
========================================================
*/

USE data_warehouse;
GO

/*==============================================================
    Procedure: bronze.load_bronze
    Purpose: Loads CRM & ERP tables into the Bronze layer
    Tracking: Execution time per table & overall batch duration
==============================================================*/

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN
    -- Declare time tracking variables
    DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME;
    DECLARE @start_time DATETIME, @end_time DATETIME;

    -- Begin execution timer
    SET @batch_start_time = GETDATE();

    BEGIN TRY
        PRINT '==============================================================';
        PRINT '🏗️ Starting Bronze Layer Data Load';
        PRINT '==============================================================';

        --------------------------------------------------------------
        -- 🏢 Load CRM Tables
        --------------------------------------------------------------
        PRINT '🔹 Loading CRM Tables';

        -- Load crm_cust_info
        PRINT '🔸 Truncating & Loading: crm_cust_info';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info;
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\ss808\OneDrive\Desktop\sqldatawarehouse project\Dataset\source_crm\cust_info.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '✅ Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Load crm_prd_info
        PRINT '🔸 Truncating & Loading: crm_prd_info';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\ss808\OneDrive\Desktop\sqldatawarehouse project\Dataset\source_crm\prd_info.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '✅ Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Load crm_sales_details
        PRINT '🔸 Truncating & Loading: crm_sales_details';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\ss808\OneDrive\Desktop\sqldatawarehouse project\Dataset\source_crm\sales_details.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '✅ Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        --------------------------------------------------------------
        -- 🏢 Load ERP Tables
        --------------------------------------------------------------
        PRINT '🔹 Loading ERP Tables';

        -- Load erp_cust_az12
        PRINT '🔸 Truncating & Loading: erp_cust_az12';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_cust_az12;
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\ss808\OneDrive\Desktop\sqldatawarehouse project\Dataset\source_erp\cust_az12.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '✅ Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Load erp_loc_a101
        PRINT '🔸 Truncating & Loading: erp_loc_a101';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\ss808\OneDrive\Desktop\sqldatawarehouse project\Dataset\source_erp\erp_loc_a101.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '✅ Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Load erp_pxt_cat_g1v2
        PRINT '🔸 Truncating & Loading: erp_pxt_cat_g1v2';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_pxt_cat_g1v2;
        BULK INSERT bronze.erp_pxt_cat_g1v2
        FROM 'C:\Users\ss808\OneDrive\Desktop\sqldatawarehouse project\Dataset\source_erp\erp_pxt_cat_g1v2.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '✅ Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Capture total batch duration
        SET @batch_end_time = GETDATE();
        PRINT '==============================================================';
        PRINT '🚀 Bronze Layer Data Load Completed';
        PRINT '⏳ Total Batch Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '==============================================================';

    END TRY
    BEGIN CATCH
        PRINT '==============================================================';
        PRINT '❌ Error Occurred During Bronze Layer Load';
        PRINT '🔹 Error Message: ' + ERROR_MESSAGE();
        PRINT '🔹 Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT '🔹 Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==============================================================';
    END CATCH;
END;
GO
