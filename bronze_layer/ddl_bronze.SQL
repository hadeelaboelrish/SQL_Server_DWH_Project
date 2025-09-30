


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '===================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===================================';

		PRINT '-----------------------------------';
		PRINT 'Loading CRM Files';
		PRINT '-----------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating TABLE: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>Inserting Data INTO: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info 
		FROM 'D:\Programming\Data with Baraa\DWH_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '-----------------------------------';
		SET @start_time = GETDATE();
		PRINT '>>Truncating TABLE: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>Inserting Data INTO: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info 
		FROM 'D:\Programming\Data with Baraa\DWH_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '-----------------------------------';
		SET @start_time = GETDATE();
		PRINT '>>Truncating TABLE: bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;
	
		PRINT '>>Inserting Data INTO: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Programming\Data with Baraa\DWH_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '-----------------------------------';
		PRINT 'Loading ERP Files';
		PRINT '-----------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating TABLE: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>Inserting Data INTO: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Programming\Data with Baraa\DWH_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '-----------------------------------';
		SET @start_time = GETDATE();
		PRINT '>>Truncating TABLE: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>Inserting Data INTO: bronze.erp_loc_a1012'
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Programming\Data with Baraa\DWH_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '-----------------------------------';
		SET @start_time = GETDATE();
		PRINT '>>Truncating TABLE: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>Inserting Data INTO: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Programming\Data with Baraa\DWH_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @batch_end_time = GETDATE();
		PRINT 'Batch Loading Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'
	END TRY
	BEGIN CATCH
	PRINT '=====================================================';
	PRINT 'ERROR OCCURED DURING LOADING BRINZE LAYER';
	PRINT 'Error message : ' + ERROR_MESSAGE();
	PRINT 'Error number : ' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error state : ' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT '=====================================================';
	END CATCH
END  
