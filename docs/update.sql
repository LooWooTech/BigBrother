-- 2020-05-22 zlj
ALTER TABLE [dbo].[node_value] DROP COLUMN [Raw_Value];

-- 2020-05-21 zlj
ALTER TABLE [dbo].[form]
    ADD [Disabled] BIT DEFAULT 0 NOT NULL;
