-- Branch
-- Customer
-- Account (deposit)
-- Loan
-- Repayment (collections)



CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY, -- serial: autoincrementing four-byte integer
    branch_name TEXT NOT NULL, -- NOT NULL as a constraint; branch must have a name
    city TEXT -- variable-length character string; optional (NULL allowed)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    kyc_status TEXT CHECK (kyc_status IN ('PENDING', 'VERIFIED')), -- KYC verification state; only allows 'PENDING' or 'VERIFIED', prevents str like 'DONE' 
    created_at TIMESTAMP DEFAULT NOW() -- date and time (no time zone); creation time = row insertion time
);


CREATE TABLE deposit_accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id), -- Foreign key to customers (an account must belong to an existing customer)
    branch_id INT REFERENCES branches(branch_id), -- FK to branches (Links account to a branch)
    account_type TEXT CHECK (account_type IN ('SAVINGS', 'CURRENT', 'FD')),
    balance NUMERIC(12,2), -- up to 12 digits total, 2 digits after decimal; Avoids floating-point rounding issues
    opened_at DATE -- Date only (no time)
);


CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    branch_id INT REFERENCES branches(branch_id),
    loan_type TEXT CHECK (loan_type IN ('HOME', 'PERSONAL', 'AUTO')),
    principal NUMERIC(12,2),
    interest_rate NUMERIC(5,2),
    tenure_months INT, -- Loan duration in months
    disbursed_at DATE, -- Date loan amount was given to customer
    status TEXT CHECK (status IN ('ACTIVE', 'CLOSED', 'NPA'))
);


CREATE TABLE repayments (
    repayment_id SERIAL PRIMARY KEY,
    loan_id INT REFERENCES loans(loan_id),
    due_date DATE,
    paid_date DATE,
    amount_due NUMERIC(12,2),
    amount_paid NUMERIC(12,2)
);

