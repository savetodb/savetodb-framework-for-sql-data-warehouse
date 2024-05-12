-- =============================================
-- SaveToDB Framework for SQL Data Warehouse
-- Version 10.13, April 29, 2024
--
-- Copyright 2018-2024 Gartle LLC
--
-- License: MIT
-- =============================================

SET NOCOUNT ON

SELECT
    CAST(s.name AS VARCHAR(15)) AS [SCHEMA]
    , CAST(o.name AS VARCHAR(40)) AS [NAME]
    , CAST(o.type_desc AS VARCHAR(20)) AS [TYPE]
FROM
    sys.objects o
    INNER JOIN sys.schemas s ON s.schema_id = o.schema_id
WHERE
    o.[type] IN ('U', 'V', 'P')
    AND s.name IN ('xls')
ORDER BY
    CASE o.[type] WHEN 'P' THEN  'Z' ELSE o.[type] END, s.name, o.name
