/*
=======================================================================================
Stored Procedure: Load Bonze Layer (Source -> Bronze)
=======================================================================================
Script Purpose:
        This Stored procedure loads data into the 'bronze" schema from external CSV files.
        It performs the following actions:
              - Truncates the bronze tables before loading data.
              - Uses the 'BULK INSERT' command to load data from CSV Files to bronze Tables.

Parameters: 
        None.
      This stored procedure does not accept any parameters or return any values.

Usage Example:
        EXEC bronze.load_bronze;
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		print '=====================================================================';
		print 'loading Bronze Layer';
		print '=====================================================================';
		
		print '----------------------------------------------------------------------';
		print 'Loading the CRM Tables';
		print '----------------------------------------------------------------------';
		
		
		SET @start_time = GETdate();
		print '>> TRUNCATE TABLE : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		print '>> INSERTING DATA INTO : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\B_HAF\Desktop\DataEngineer\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETdate();
		PRINT'>> Load Duration:' +CAST(DATEDIFF(second, @start_time, @end_time)AS VARCHAR) + 'seconds';
		PRINT'>> --------------';
		
		SET @start_time = GETdate();
		print '>> TRUNCATE TABLE : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		print '>> INSERTING DATA INTO : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\B_HAF\Desktop\DataEngineer\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETdate();
		PRINT'>> Load Duration:' +CAST(DATEDIFF(second, @start_time, @end_time)AS VARCHAR) + 'seconds';
		PRINT'>> --------------';
		
		SET @start_time = GETdate();
		print '>> TRUNCATE TABLE : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		print '>> INSERTING DATA INTO : bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details 
		FROM 'C:\Users\B_HAF\Desktop\DataEngineer\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETdate();
		PRINT'>> Load Duration:' +CAST(DATEDIFF(second, @start_time, @end_time)AS VARCHAR) + 'seconds';
		PRINT'>> --------------';
		print '----------------------------------------------------------------------';
		print 'Loading the ERP TableS';
		print '----------------------------------------------------------------------';
		
		SET @start_time = GETdate();
		print '>> TRUNCATE TABLE : bronze.erp_CUST_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;
		print '>> INSERTING DATA INTO : bronze.erp_CUST_AZ12';
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\B_HAF\Desktop\DataEngineer\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETdate();
		PRINT'>> Load Duration:' +CAST(DATEDIFF(second, @start_time, @end_time)AS VARCHAR) + 'seconds';
		PRINT'>> --------------';
		
		SET @start_time = GETdate();
		print '>> TRUNCATE TABLE : bronze.erp_LOC_A101';
		TRUNCATE TABLE bronze.erp_LOC_A101;
		print '>> INSERTING DATA INTO : bronze.erp_LOC_A101';
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Users\B_HAF\Desktop\DataEngineer\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETdate();
		PRINT'>> Load Duration:' +CAST(DATEDIFF(second, @start_time, @end_time)AS VARCHAR) + 'seconds';
		PRINT'>> --------------';
		
		SET @start_time = GETdate();
		print '>> TRUNCATE TABLE : bronze.erp_PX_CAT_G1V2';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		print '>> INSERTING DATA INTO : bronze.erp_PX_CAT_G1V2';
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\B_HAF\Desktop\DataEngineer\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETdate();
		PRINT'>> Load Duration:' +CAST(DATEDIFF(second, @start_time, @end_time)AS VARCHAR) + 'seconds';
		PRINT'>> --------------';

		SET @batch_end_time = GETDATE();
		PRINT'====================================================================='
		PRINT'Loading Bronz Layer is Completed';
		PRINT'      - Total Load Duration:' +CAST(DATEDIFF(second, @batch_start_time, @batch_end_time)AS VARCHAR) + ' seconds';
		PRINT'====================================================================='

	END TRY
	BEGIN CATCH
		PRINT'====================================================================='
		PRINT'Error occured during loading the bronze layer'
		PRINT'Error message' + ERROR_MESSAGE();
		PRINT'Error message' + CAST(ERROR_NUMBER() AS VARCHAR);
		PRINT'Error message' + CAST(ERROR_STATE() AS VARCHAR);
		PRINT'====================================================================='
	END CATCH
END
