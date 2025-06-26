SHOW TABLES;

DROP TABLE IF EXISTS target_audience;

CREATE TABLE target_audience (
    user_id STRING COMMENT 'Unique identifier for the user',
    email STRING COMMENT 'User email address',
    first_name STRING,
    last_name STRING,
    last_login_timestamp TIMESTAMP
)
PARTITIONED BY (
    audience_id INT COMMENT 'Identifier for the audience segment',
    day DATE COMMENT 'Partition key for the specific day of data'
)
STORED AS PARQUET;
-- LOCATION 'gs://dingoproc/table-data';

INSERT INTO target_audience
VALUES
    ('user_001', 'user001@example.com', 'John', 'Doe', current_timestamp(), 101, CAST('2025-06-24' AS DATE)),
    ('user_002', 'user002@example.com', 'Jane', 'Smith', current_timestamp(), 101, CAST('2025-06-24' AS DATE)),
    ('user_003', 'user003@example.com', 'Peter', 'Jones', current_timestamp(), 102, CAST('2025-06-24' AS DATE)),
    ('user_004', 'user004@example.com', 'Mary', 'Jane', current_timestamp(), 101, CAST('2025-06-25' AS DATE)),
    ('user_005', 'user005@example.com', 'Sue', 'Storm', current_timestamp(), 101, CAST('2025-06-25' AS DATE)),
    ('user_006', 'user006@example.com', 'Reed', 'Richards', current_timestamp(), 102, CAST('2025-06-25' AS DATE)),
    ('user_007', 'user007@example.com', 'Ben', 'Grimm', current_timestamp(), 102, CAST('2025-06-25' AS DATE)),
    ('user_008', 'user008@example.com', 'Johnny', 'Storm', current_timestamp(), 101, CAST('2025-06-26' AS DATE)),
    ('user_009', 'user009@example.com', 'Victor', 'Doom', current_timestamp(), 101, CAST('2025-06-26' AS DATE)),
    ('user_010', 'user010@example.com', 'Norrin', 'Radd', current_timestamp(), 102, CAST('2025-06-26' AS DATE));

SELECT
    user_id,
    email,
    audience_id,
    day
FROM
    target_audience
WHERE
    day = CAST('2025-06-25' AS DATE)
LIMIT 10;
