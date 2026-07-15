CREATE PROCEDURE silver.sp_process_uob_tickets
AS
BEGIN
    SET NOCOUNT ON;
    
    TRUNCATE TABLE silver.ism_ticket_cleansed;

    -- Insert curated data and calculate SLA thresholds dynamically
    INSERT INTO silver.ism_ticket_cleansed (
        ticket_id, agent_id, issue_category, priority_level, 
        open_datetime, resolve_datetime, sla_target_hours, sla_breached_flag, source_name
    )
    SELECT 
        ticket_id, 
        agent_id, 
        issue_category, 
        priority_level,
        TRY_CAST(open_time AS DATETIME),
        TRY_CAST(resolve_time AS DATETIME),
        -- Assign SLA Targets based on Priority Level
        CASE 
            WHEN priority_level = 'P1' THEN 4
            WHEN priority_level = 'P2' THEN 12
            WHEN priority_level = 'P3' THEN 24
            ELSE 48 
        END AS sla_target_hours,
        -- Determine if SLA was breached
        CASE 
            WHEN DATEDIFF(HOUR, TRY_CAST(open_time AS DATETIME), TRY_CAST(resolve_time AS DATETIME)) > 
                 CASE 
                    WHEN priority_level = 'P1' THEN 4
                    WHEN priority_level = 'P2' THEN 12
                    WHEN priority_level = 'P3' THEN 24
                    ELSE 48 
                 END 
            THEN 1 ELSE 0 
        END AS sla_breached_flag,
        source_name
    FROM bronze.ism_ticket_data
    WHERE agent_id IS NOT NULL AND resolve_time IS NOT NULL;
END;
