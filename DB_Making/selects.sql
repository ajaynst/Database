select * from branches;

select * from deposit_accounts;

select * from loans;

select * from customers;

select * from repayments;

truncate table deposit_accounts, loans, repayments, customers, branches;

SHOW search_path;

SELECT schemaname, tablename
FROM pg_catalog.pg_tables;


-- query to show all tables
SELECT * FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND 
    schemaname != 'information_schema';
    

-- cust with verified KYC
SELECT *
FROM customers
WHERE kyc_status = 'VERIFIED';




-- Deposit accounts of specific types
SELECT *
FROM deposit_accounts
WHERE account_type IN ('SAVINGS', 'FD');


-- Loans disbursed in a date range
SELECT *
FROM loans
WHERE disbursed_at BETWEEN '2023-01-01' AND '2023-12-31';




