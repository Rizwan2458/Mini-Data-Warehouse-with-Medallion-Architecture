CREATE OR REPLACE PROCEDURE BRONZE.LOAD_BRONZE()
LANGUAGE PLPGSQL
AS $$
DECLARE
    START_TIME TIMESTAMP;
    END_TIME TIMESTAMP;
    BATCH_START_TIME TIMESTAMP;
    BATCH_END_TIME TIMESTAMP;
BEGIN
    BATCH_START_TIME := NOW();
    RAISE NOTICE '================================================';
    RAISE NOTICE 'LOADING BRONZE LAYER';
    RAISE NOTICE '================================================';

    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'LOADING CRM TABLES';
    RAISE NOTICE '------------------------------------------------';

    START_TIME := NOW();
    TRUNCATE TABLE BRONZE.CRM_CUST_INFO;
    COPY BRONZE.CRM_CUST_INFO FROM 'C:\data\warehouse\cust_info.csv'
        WITH (FORMAT CSV, HEADER TRUE);
    END_TIME := NOW();
    RAISE NOTICE 'CRM_CUST_INFO LOADED IN % SECONDS', EXTRACT(EPOCH FROM (END_TIME - START_TIME));

    START_TIME := NOW();
    TRUNCATE TABLE BRONZE.CRM_PRD_INFO;
    COPY BRONZE.CRM_PRD_INFO FROM 'C:\data\warehouse\prd_info.csv'
        WITH (FORMAT CSV, HEADER TRUE);
    END_TIME := NOW();
    RAISE NOTICE 'CRM_PRD_INFO LOADED IN % SECONDS', EXTRACT(EPOCH FROM (END_TIME - START_TIME));

    START_TIME := NOW();
    TRUNCATE TABLE BRONZE.CRM_SALES_DETAILS;
    COPY BRONZE.CRM_SALES_DETAILS FROM 'C:\data\warehouse\sales_details.csv'
        WITH (FORMAT CSV, HEADER TRUE);
    END_TIME := NOW();
    RAISE NOTICE 'CRM_SALES_DETAILS LOADED IN % SECONDS', EXTRACT(EPOCH FROM (END_TIME - START_TIME));

    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'LOADING ERP TABLES';
    RAISE NOTICE '------------------------------------------------';

    START_TIME := NOW();
    TRUNCATE TABLE BRONZE.ERP_LOC_A101;
    COPY BRONZE.ERP_LOC_A101 FROM 'C:\data\warehouse\LOC_A101.csv'
        WITH (FORMAT CSV, HEADER TRUE);
    END_TIME := NOW();
    RAISE NOTICE 'ERP_LOC_A101 LOADED IN % SECONDS', EXTRACT(EPOCH FROM (END_TIME - START_TIME));

    START_TIME := NOW();
    TRUNCATE TABLE BRONZE.ERP_CUST_AZ12;
    COPY BRONZE.ERP_CUST_AZ12 FROM 'C:\data\warehouse\CUST_AZ12.csv'
        WITH (FORMAT CSV, HEADER TRUE);
    END_TIME := NOW();
    RAISE NOTICE 'ERP_CUST_AZ12 LOADED IN % SECONDS', EXTRACT(EPOCH FROM (END_TIME - START_TIME));

    START_TIME := NOW();
    TRUNCATE TABLE BRONZE.ERP_PX_CAT_G1V2;
    COPY BRONZE.ERP_PX_CAT_G1V2 FROM 'C:\data\warehouse\PX_CAT_G1V2.csv'
        WITH (FORMAT CSV, HEADER TRUE);
    END_TIME := NOW();
    RAISE NOTICE 'ERP_PX_CAT_G1V2 LOADED IN % SECONDS', EXTRACT(EPOCH FROM (END_TIME - START_TIME));

    BATCH_END_TIME := NOW();
    RAISE NOTICE '================================================';
    RAISE NOTICE 'BRONZE LAYER LOAD COMPLETED IN % SECONDS', EXTRACT(EPOCH FROM (BATCH_END_TIME - BATCH_START_TIME));
    RAISE NOTICE '================================================';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE '================================================';
        RAISE NOTICE 'ERROR WHILE LOADING BRONZE LAYER';
        RAISE NOTICE 'ERROR: %', SQLERRM;
        RAISE NOTICE 'STATE: %', SQLSTATE;
        RAISE NOTICE '================================================';
END;
$$;

CALL BRONZE.LOAD_BRONZE();