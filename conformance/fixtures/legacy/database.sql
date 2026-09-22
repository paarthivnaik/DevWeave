CREATE TABLE raw_transactions (
    id INT PRIMARY KEY,
    legacy_code VARCHAR(50),
    amount DECIMAL(10,2),
    status INT
);
