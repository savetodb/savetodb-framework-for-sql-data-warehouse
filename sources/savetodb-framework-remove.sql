-- =============================================
-- SaveToDB Framework for SQL Data Warehouse
-- Version 10.6, December 13, 2022
--
-- Copyright 2018-2022 Gartle LLC
--
-- License: MIT
-- =============================================

SET NOCOUNT ON
GO

IF OBJECT_ID('[xls].[xl_actions_set_framework_10_mode]', 'P') IS NOT NULL
DROP PROCEDURE [xls].[xl_actions_set_framework_10_mode];
GO
IF OBJECT_ID('[xls].[xl_actions_set_framework_9_mode]', 'P') IS NOT NULL
DROP PROCEDURE [xls].[xl_actions_set_framework_9_mode];
GO
IF OBJECT_ID('[xls].[xl_actions_set_extended_role_permissions]', 'P') IS NOT NULL
DROP PROCEDURE [xls].[xl_actions_set_extended_role_permissions];
GO
IF OBJECT_ID('[xls].[xl_actions_revoke_extended_role_permissions]', 'P') IS NOT NULL
DROP PROCEDURE [xls].[xl_actions_revoke_extended_role_permissions];
GO
IF OBJECT_ID('[xls].[xl_actions_set_role_permissions]', 'P') IS NOT NULL
DROP PROCEDURE [xls].[xl_actions_set_role_permissions];
GO
IF OBJECT_ID('[xls].[xl_update_table_format]', 'P') IS NOT NULL
DROP PROCEDURE [xls].[xl_update_table_format];
GO

IF OBJECT_ID('[xls].[queries]', 'V') IS NOT NULL
DROP VIEW [xls].[queries];
GO
IF OBJECT_ID('[xls].[users]', 'V') IS NOT NULL
DROP VIEW [xls].[users];
GO
IF OBJECT_ID('[xls].[view_columns]', 'V') IS NOT NULL
DROP VIEW [xls].[view_columns];
GO
IF OBJECT_ID('[xls].[view_formats]', 'V') IS NOT NULL
DROP VIEW [xls].[view_formats];
GO
IF OBJECT_ID('[xls].[view_handlers]', 'V') IS NOT NULL
DROP VIEW [xls].[view_handlers];
GO
IF OBJECT_ID('[xls].[view_objects]', 'V') IS NOT NULL
DROP VIEW [xls].[view_objects];
GO
IF OBJECT_ID('[xls].[view_queries]', 'V') IS NOT NULL
DROP VIEW [xls].[view_queries];
GO
IF OBJECT_ID('[xls].[view_translations]', 'V') IS NOT NULL
DROP VIEW [xls].[view_translations];
GO
IF OBJECT_ID('[xls].[view_workbooks]', 'V') IS NOT NULL
DROP VIEW [xls].[view_workbooks];
GO

IF OBJECT_ID('[xls].[columns]', 'U') IS NOT NULL
DROP TABLE [xls].[columns];
GO
IF OBJECT_ID('[xls].[formats]', 'U') IS NOT NULL
DROP TABLE [xls].[formats];
GO
IF OBJECT_ID('[xls].[handlers]', 'U') IS NOT NULL
DROP TABLE [xls].[handlers];
GO
IF OBJECT_ID('[xls].[objects]', 'U') IS NOT NULL
DROP TABLE [xls].[objects];
GO
IF OBJECT_ID('[xls].[translations]', 'U') IS NOT NULL
DROP TABLE [xls].[translations];
GO
IF OBJECT_ID('[xls].[workbooks]', 'U') IS NOT NULL
DROP TABLE [xls].[workbooks];
GO


DECLARE @sql nvarchar(max) = ''

SELECT
    @sql = @sql + 'ALTER ROLE ' + QUOTENAME(r.name) + ' DROP MEMBER ' + QUOTENAME(m.name) + ';' + CHAR(13) + CHAR(10)
FROM
    sys.database_role_members rm
    INNER JOIN sys.database_principals r ON r.principal_id = rm.role_principal_id
    INNER JOIN sys.database_principals m ON m.principal_id = rm.member_principal_id
WHERE
    r.name IN ('xls_admins', 'xls_developers', 'xls_formats', 'xls_users')

IF LEN(@sql) > 1
    BEGIN
    EXEC (@sql);
    PRINT @sql
    END
GO

IF DATABASE_PRINCIPAL_ID('xls_admins') IS NOT NULL
DROP ROLE [xls_admins];
GO
IF DATABASE_PRINCIPAL_ID('xls_developers') IS NOT NULL
DROP ROLE [xls_developers];
GO
IF DATABASE_PRINCIPAL_ID('xls_formats') IS NOT NULL
DROP ROLE [xls_formats];
GO
IF DATABASE_PRINCIPAL_ID('xls_users') IS NOT NULL
DROP ROLE [xls_users];
GO

IF SCHEMA_ID('xls') IS NOT NULL
DROP SCHEMA [xls];
GO

print 'SaveToDB Framework removed';
