-- Cleansed table with SLA Business Logic applied
CREATE TABLE silver.ism_ticket_cleansed (
    ticket_id NVARCHAR(50) PRIMARY KEY,
    agent_id INT NOT NULL,
    issue_category NVARCHAR(100),
    priority_level NVARCHAR(50),
    
    -- Casted timestamps
    open_datetime DATETIME,
    resolve_datetime DATETIME,
    
    -- Business Logic: Calculate actual resolution time in hours
    resolution_time_hours AS DATEDIFF(HOUR, open_datetime, resolve_datetime),
    
    -- Business Logic: Target SLA hours based on Priority
    sla_target_hours INT,
    
    -- Business Logic: Flag for SLA Breach (1 = Breached, 0 = Met)
    sla_breached_flag INT,
    
    source_name VARCHAR(50),
    dwh_creation_date DATETIME DEFAULT GETDATE()
);
