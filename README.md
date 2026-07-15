# HP(via Mphasis) - Bank IT Service Operations Analytics
*End-to-End SQL to Excel Data Pipeline for SLA Tracking, IVR Deflection, and Automated Agent Incentive Calculations.*

## Project Overview

Developed an operational data warehouse for the UOB Bank IT Helpdesk project (via HP/Mphasis). This pipeline extracted unstructured ticketing data from the **ISM Ticketing Tool** into a centralized SQL Server database. The curated data was then directly connected to Advanced Excel via Power Query to drive three major business initiatives:
1. **SLA Breach Analytics:** Identifying resolution bottlenecks across the team.
2. **IVR Deflection:** Isolating high-frequency, low-complexity issues to be integrated into automated IVR solutions.
3. **Incentive Automation:** A dynamic Excel tool utilizing dropdown criteria to automatically calculate agent incentives based on performance slabs and SQL backend data.

## Architecture & Data Flow

*   **Data Extraction:** CSV exports of ticket logs from the ISM Ticketing Tool.
*   **SQL Server Data Warehouse (Medallion Structure):**
    *   **Bronze:** Bulk insertion of raw ticket data (retaining raw text/integer formats).
    *   **Silver:** Transformation layer to standardizing dates, handle missing agent IDs, and calculate the critical `sla_breached_flag` based on ticket priority targets.
    *   **Gold:** Dimensional modeling separating agent data, issue categories, and ticket resolution facts.
*   **Frontend Integration (Excel):** Connected the SQL Gold layer directly to Excel. Built a custom VBA/Formula-driven dashboard where managers could select an agent via dropdown to instantly pull SLA performance and calculate monetary incentives.

---
