--  BANK MANAGEMENT SYSTEM — SQL Script
--  15 Tables + Sample Data

-- TABLE 1: BRANCHES
CREATE TABLE Branches (
    branch_id     INT PRIMARY KEY AUTO_INCREMENT,
    branch_name   VARCHAR(100) NOT NULL,
    address       VARCHAR(200),
    city          VARCHAR(50),
    state         VARCHAR(50),
    phone         VARCHAR(15),
    established   DATE
);

INSERT INTO Branches (branch_name, address, city, state, phone, established) VALUES
('Main Branch',    '123 Bank Street',     'Karachi',    'Sindh',          '021-1111111', '2000-01-15'),
('North Branch',   '45 North Avenue',     'Lahore',     'Punjab',         '042-2222222', '2005-06-10'),
('East Branch',    '78 East Road',        'Islamabad',  'Islamabad',      '051-3333333', '2010-03-22'),
('West Branch',    '90 West Boulevard',   'Peshawar',   'KPK',            '091-4444444', '2012-07-30'),
('South Branch',   '12 South Lane',       'Quetta',     'Balochistan',    '081-5555555', '2015-09-05');


-- TABLE 2: DEPARTMENTS
CREATE TABLE Departments (
    dept_id     INT PRIMARY KEY AUTO_INCREMENT,
    dept_name   VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

INSERT INTO Departments (dept_name, description) VALUES
('Customer Service',  'Handles walk-in customers and inquiries'),
('Loans',             'Manages personal and business loan applications'),
('IT',                'Maintains bank systems and infrastructure'),
('Accounts',          'Manages account opening and closure'),
('Risk & Compliance', 'Ensures regulatory compliance and risk management');


-- TABLE 3: EMPLOYEES
CREATE TABLE Employees (
    employee_id   INT PRIMARY KEY AUTO_INCREMENT,
    branch_id     INT NOT NULL,
    dept_id       INT NOT NULL,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    email         VARCHAR(100) UNIQUE,
    phone         VARCHAR(15),
    hire_date     DATE,
    salary        DECIMAL(12,2),
    position      VARCHAR(50),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (dept_id)   REFERENCES Departments(dept_id)
);

INSERT INTO Employees (branch_id, dept_id, first_name, last_name, email, phone, hire_date, salary, position) VALUES
(1, 1, 'Ali',     'Khan',    'ali.khan@bank.pk',     '0300-1111111', '2015-03-01', 85000.00, 'Branch Manager'),
(1, 2, 'Sara',    'Ahmed',   'sara.ahmed@bank.pk',   '0300-2222222', '2018-07-15', 55000.00, 'Loan Officer'),
(2, 1, 'Usman',   'Farooq',  'usman.f@bank.pk',      '0300-3333333', '2019-01-10', 50000.00', 'Customer Service Rep'),
(2, 4, 'Aisha',   'Malik',   'aisha.m@bank.pk',      '0300-4444444', '2017-05-20', 60000.00, 'Accounts Officer'),
(3, 3, 'Bilal',   'Sheikh',  'bilal.s@bank.pk',      '0300-5555555', '2020-09-01', 70000.00, 'IT Specialist'),
(3, 5, 'Fatima',  'Raza',    'fatima.r@bank.pk',     '0300-6666666', '2016-11-11', 65000.00, 'Compliance Officer'),
(4, 2, 'Hassan',  'Ali',     'hassan.a@bank.pk',     '0300-7777777', '2021-02-14', 52000.00, 'Loan Officer'),
(5, 1, 'Nadia',   'Iqbal',   'nadia.i@bank.pk',      '0300-8888888', '2022-06-30', 48000.00, 'Customer Service Rep');


-- TABLE 4: CUSTOMERS
CREATE TABLE Customers (
    customer_id   INT PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    email         VARCHAR(100) UNIQUE,
    phone         VARCHAR(15),
    cnic          VARCHAR(15) UNIQUE,
    date_of_birth DATE,
    address       VARCHAR(200),
    city          VARCHAR(50),
    join_date     DATE DEFAULT (CURRENT_DATE),
    status        ENUM('Active', 'Inactive', 'Blocked') DEFAULT 'Active'
);

INSERT INTO Customers (first_name, last_name, email, phone, cnic, date_of_birth, address, city, join_date) VALUES
('Ahmed',   'Siddiqui', 'ahmed.s@email.com',  '0311-1111111', '42101-1234567-1', '1985-04-12', '10 Garden Road',     'Karachi',   '2018-01-05'),
('Zara',    'Hussain',  'zara.h@email.com',   '0311-2222222', '35202-2345678-2', '1990-08-25', '22 Model Town',      'Lahore',    '2019-03-15'),
('Omar',    'Farhan',   'omar.f@email.com',   '0311-3333333', '61101-3456789-3', '1978-12-01', '5 Blue Area',        'Islamabad', '2017-06-20'),
('Hina',    'Bashir',   'hina.b@email.com',   '0311-4444444', '17301-4567890-4', '1995-02-18', '8 Hayatabad',        'Peshawar',  '2020-09-10'),
('Kamran',  'Lodhi',    'kamran.l@email.com', '0311-5555555', '50101-5678901-5', '1982-07-30', '3 Jinnah Road',      'Quetta',    '2016-12-01'),
('Saba',    'Nawaz',    'saba.n@email.com',   '0311-6666666', '42301-6789012-6', '1993-11-09', '15 Clifton Block 5', 'Karachi',   '2021-04-22'),
('Tariq',   'Mehmood',  'tariq.m@email.com',  '0311-7777777', '35401-7890123-7', '1987-03-14', '7 DHA Phase 4',      'Lahore',    '2022-01-30'),
('Mariam',  'Qureshi',  'mariam.q@email.com', '0311-8888888', '61201-8901234-8', '1999-06-28', '9 G-11 Markaz',      'Islamabad', '2023-07-05');


-- TABLE 5: ACCOUNTS
CREATE TABLE Accounts (
    account_id      INT PRIMARY KEY AUTO_INCREMENT,
    customer_id     INT NOT NULL,
    branch_id       INT NOT NULL,
    account_number  VARCHAR(20) UNIQUE NOT NULL,
    account_type    ENUM('Savings', 'Current', 'Business', 'Salary') NOT NULL,
    balance         DECIMAL(15,2) DEFAULT 0.00,
    open_date       DATE,
    status          ENUM('Active', 'Dormant', 'Closed') DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (branch_id)   REFERENCES Branches(branch_id)
);

INSERT INTO Accounts (customer_id, branch_id, account_number, account_type, balance, open_date) VALUES
(1, 1, 'ACC-1001-0001', 'Savings',  250000.00,  '2018-01-10'),
(2, 2, 'ACC-2001-0002', 'Current',  520000.00,  '2019-03-20'),
(3, 3, 'ACC-3001-0003', 'Business', 1800000.00, '2017-06-25'),
(4, 4, 'ACC-4001-0004', 'Savings',  75000.00,   '2020-09-15'),
(5, 5, 'ACC-5001-0005', 'Current',  350000.00,  '2016-12-05'),
(6, 1, 'ACC-1001-0006', 'Salary',   120000.00,  '2021-04-28'),
(7, 2, 'ACC-2001-0007', 'Savings',  430000.00,  '2022-02-01'),
(8, 3, 'ACC-3001-0008', 'Business', 950000.00,  '2023-07-10');


-- TABLE 6: TRANSACTION TYPES
CREATE TABLE Transaction_Types (
    type_id     INT PRIMARY KEY AUTO_INCREMENT,
    type_name   VARCHAR(50) NOT NULL,
    description VARCHAR(200)
);

INSERT INTO Transaction_Types (type_name, description) VALUES
('Deposit',       'Cash or cheque deposited into account'),
('Withdrawal',    'Cash withdrawn from account'),
('Transfer',      'Funds transferred between accounts'),
('Bill Payment',  'Utility or service bill paid'),
('ATM',           'Transaction via ATM machine'),
('Online',        'Internet or mobile banking transaction'),
('IBFT',          'Interbank funds transfer');


-- TABLE 7: TRANSACTIONS
CREATE TABLE Transactions (
    txn_id          INT PRIMARY KEY AUTO_INCREMENT,
    account_id      INT NOT NULL,
    type_id         INT NOT NULL,
    amount          DECIMAL(15,2) NOT NULL,
    txn_date        DATETIME DEFAULT CURRENT_TIMESTAMP,
    description     VARCHAR(255),
    reference_no    VARCHAR(30) UNIQUE,
    balance_after   DECIMAL(15,2),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (type_id)    REFERENCES Transaction_Types(type_id)
);

INSERT INTO Transactions (account_id, type_id, amount, txn_date, description, reference_no, balance_after) VALUES
(1, 1,  50000.00,  '2024-01-05 10:30:00', 'Salary credit',         'REF-20240105-001', 300000.00),
(1, 2,  15000.00,  '2024-01-10 14:00:00', 'Cash withdrawal',       'REF-20240110-001', 285000.00),
(2, 3,  100000.00, '2024-01-12 09:00:00', 'Transfer to supplier',  'REF-20240112-001', 420000.00),
(3, 4,  8500.00,   '2024-01-15 11:00:00', 'Electricity bill',      'REF-20240115-001', 1791500.00),
(4, 5,  5000.00,   '2024-01-18 16:00:00', 'ATM withdrawal',        'REF-20240118-001', 70000.00),
(5, 6,  30000.00,  '2024-02-01 10:00:00', 'Online shopping',       'REF-20240201-001', 320000.00),
(6, 7,  20000.00,  '2024-02-05 13:00:00', 'IBFT to Meezan Bank',   'REF-20240205-001', 100000.00),
(7, 1,  75000.00,  '2024-02-10 09:30:00', 'Business revenue',      'REF-20240210-001', 505000.00),
(8, 2,  50000.00,  '2024-02-15 15:00:00', 'Equipment purchase',    'REF-20240215-001', 900000.00),
(1, 3,  25000.00,  '2024-03-01 11:00:00', 'Rent payment',          'REF-20240301-001', 260000.00);


-- TABLE 8: LOAN TYPES
    loan_type_id    INT PRIMARY KEY AUTO_INCREMENT,
    type_name       VARCHAR(100) NOT NULL,
    interest_rate   DECIMAL(5,2) NOT NULL,
    max_term_months INT,
    description     VARCHAR(255)
);

INSERT INTO Loan_Types (type_name, interest_rate, max_term_months, description) VALUES
('Personal Loan',   14.00, 60,  'Unsecured personal finance loan'),
('Home Loan',        9.50, 240, 'Mortgage-backed home financing'),
('Car Loan',        12.00, 60,  'Vehicle purchase financing'),
('Business Loan',   13.50, 120, 'Working capital or business expansion'),
('Education Loan',  10.00, 84,  'Higher education financing'),
('Agricultural',     8.00, 36,  'Farm and crop financing');

-- TABLE 9: LOANS
CREATE TABLE Loans (
    loan_id         INT PRIMARY KEY AUTO_INCREMENT,
    customer_id     INT NOT NULL,
    account_id      INT NOT NULL,
    employee_id     INT NOT NULL,
    loan_type_id    INT NOT NULL,
    principal       DECIMAL(15,2) NOT NULL,
    interest_rate   DECIMAL(5,2) NOT NULL,
    term_months     INT NOT NULL,
    start_date      DATE,
    end_date        DATE,
    status          ENUM('Pending', 'Active', 'Closed', 'Defaulted') DEFAULT 'Pending',
    FOREIGN KEY (customer_id)  REFERENCES Customers(customer_id),
    FOREIGN KEY (account_id)   REFERENCES Accounts(account_id),
    FOREIGN KEY (employee_id)  REFERENCES Employees(employee_id),
    FOREIGN KEY (loan_type_id) REFERENCES Loan_Types(loan_type_id)
);

INSERT INTO Loans (customer_id, account_id, employee_id, loan_type_id, principal, interest_rate, term_months, start_date, end_date, status) VALUES
(1, 1, 2, 1,  500000.00,  14.00, 36, '2023-01-01', '2026-01-01', 'Active'),
(2, 2, 7, 4, 2000000.00,  13.50, 60, '2022-06-01', '2027-06-01', 'Active'),
(3, 3, 2, 2, 5000000.00,   9.50, 120,'2021-03-15', '2031-03-15', 'Active'),
(4, 4, 7, 3,  800000.00,  12.00, 48, '2023-09-01', '2027-09-01', 'Active'),
(5, 5, 2, 5,  300000.00,  10.00, 60, '2022-01-01', '2027-01-01', 'Active'),
(6, 6, 7, 1,  150000.00,  14.00, 24, '2024-01-01', '2026-01-01', 'Active');

-- TABLE 10: LOAN PAYMENTS
CREATE TABLE Loan_Payments (
    payment_id      INT PRIMARY KEY AUTO_INCREMENT,
    loan_id         INT NOT NULL,
    payment_date    DATE NOT NULL,
    amount_paid     DECIMAL(12,2) NOT NULL,
    principal_part  DECIMAL(12,2),
    interest_part   DECIMAL(12,2),
    remaining_balance DECIMAL(15,2),
    payment_method  ENUM('Cash', 'Cheque', 'Online', 'Auto-debit') DEFAULT 'Auto-debit',
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);

INSERT INTO Loan_Payments (loan_id, payment_date, amount_paid, principal_part, interest_part, remaining_balance, payment_method) VALUES
(1, '2023-02-01', 17046.00, 11213.00, 5833.00, 488787.00, 'Auto-debit'),
(1, '2023-03-01', 17046.00, 11344.00, 5702.00, 477443.00, 'Auto-debit'),
(2, '2022-07-01', 45584.00, 22917.00, 22667.00, 1977083.00, 'Auto-debit'),
(3, '2021-04-15', 52177.00, 10583.00, 39594.00, 4989417.00, 'Auto-debit'),
(4, '2023-10-01', 21026.00, 13026.00, 8000.00,  786974.00, 'Online'),
(5, '2022-02-01', 6380.00,  3880.00,  2500.00,  296120.00, 'Cheque'),
(6, '2024-02-01', 7207.00,  5457.00,  1750.00,  144543.00, 'Auto-debit');

-- TABLE 11: CARDS
CREATE TABLE Cards (
    card_id         INT PRIMARY KEY AUTO_INCREMENT,
    account_id      INT NOT NULL,
    customer_id     INT NOT NULL,
    card_number     VARCHAR(19) UNIQUE NOT NULL,
    card_type       ENUM('Debit', 'Credit', 'Prepaid') NOT NULL,
    card_network    ENUM('Visa', 'Mastercard', 'UnionPay') DEFAULT 'Visa',
    issue_date      DATE,
    expiry_date     DATE,
    credit_limit    DECIMAL(12,2) DEFAULT NULL,
    status          ENUM('Active', 'Blocked', 'Expired') DEFAULT 'Active',
    FOREIGN KEY (account_id)  REFERENCES Accounts(account_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Cards (account_id, customer_id, card_number, card_type, card_network, issue_date, expiry_date, credit_limit) VALUES
(1, 1, '4111-1111-1111-0001', 'Debit',  'Visa',       '2022-01-01', '2027-01-01', NULL),
(2, 2, '5200-8282-8282-0002', 'Credit', 'Mastercard', '2021-06-01', '2026-06-01', 200000.00),
(3, 3, '4532-1234-5678-0003', 'Credit', 'Visa',       '2020-03-01', '2025-03-01', 500000.00),
(4, 4, '6250-9460-0000-0004', 'Debit',  'UnionPay',   '2023-01-01', '2028-01-01', NULL),
(5, 5, '5500-0055-5555-0005', 'Credit', 'Mastercard', '2019-12-01', '2024-12-01', 300000.00),
(6, 6, '4111-0000-1234-0006', 'Debit',  'Visa',       '2024-01-01', '2029-01-01', NULL),
(7, 7, '5200-4444-3333-0007', 'Credit', 'Mastercard', '2023-05-01', '2028-05-01', 150000.00),
(8, 8, '4532-9999-8888-0008', 'Debit',  'Visa',       '2023-07-01', '2028-07-01', NULL);

-- TABLE 12: BENEFICIARIES
CREATE TABLE Beneficiaries (
    ben_id          INT PRIMARY KEY AUTO_INCREMENT,
    customer_id     INT NOT NULL,
    ben_name        VARCHAR(100) NOT NULL,
    bank_name       VARCHAR(100),
    account_number  VARCHAR(30) NOT NULL,
    iban            VARCHAR(34),
    relationship    VARCHAR(50),
    added_date      DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Beneficiaries (customer_id, ben_name, bank_name, account_number, iban, relationship, added_date) VALUES
(1, 'Rizwan Khan',    'HBL',          'PK36HABB0000049123456702', 'PK36HABB0000049123456702', 'Brother',   '2021-03-10'),
(2, 'Amna Hussain',   'Meezan Bank',  'PK70MEZN0001234567890112', 'PK70MEZN0001234567890112', 'Mother',    '2020-08-20'),
(3, 'Tech Corp Ltd',  'UBL',          'PK29UNIL0109000100058001', 'PK29UNIL0109000100058001', 'Vendor',    '2018-01-15'),
(4, 'Ali Bashir',     'Bank Alfalah', 'PK46ALFH0123456789012345', 'PK46ALFH0123456789012345', 'Spouse',    '2022-05-01'),
(5, 'Lodhi Farms',    'MCB',          'PK55MCBL0103000067010422', 'PK55MCBL0103000067010422', 'Business',  '2019-11-11'),
(1, 'Saima Siddiqui', 'Allied Bank',  'PK07ABPA0000000001020010', 'PK07ABPA0000000001020010', 'Sister',    '2023-02-14');

-- TABLE 13: FIXED DEPOSITS
CREATE TABLE Fixed_Deposits (
    fd_id           INT PRIMARY KEY AUTO_INCREMENT,
    account_id      INT NOT NULL,
    fd_number       VARCHAR(20) UNIQUE NOT NULL,
    amount          DECIMAL(15,2) NOT NULL,
    interest_rate   DECIMAL(5,2) NOT NULL,
    start_date      DATE NOT NULL,
    maturity_date   DATE NOT NULL,
    maturity_amount DECIMAL(15,2),
    auto_renew      BOOLEAN DEFAULT FALSE,
    status          ENUM('Active', 'Matured', 'Broken') DEFAULT 'Active',
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

INSERT INTO Fixed_Deposits (account_id, fd_number, amount, interest_rate, start_date, maturity_date, maturity_amount, auto_renew) VALUES
(1, 'FD-2023-0001', 100000.00,  9.50, '2023-01-01', '2024-01-01', 109500.00,  TRUE),
(2, 'FD-2022-0002', 500000.00, 10.00, '2022-06-01', '2025-06-01', 665500.00,  FALSE),
(3, 'FD-2021-0003', 1000000.00, 11.00,'2021-03-01', '2024-03-01', 1363000.00, TRUE),
(5, 'FD-2023-0004', 200000.00,  9.75, '2023-01-15', '2024-07-15', 219500.00,  FALSE),
(7, 'FD-2024-0005', 300000.00, 10.50, '2024-01-01', '2025-01-01', 331500.00,  TRUE);

-- TABLE 14: AUDIT LOG
CREATE TABLE Audit_Log (
    log_id          INT PRIMARY KEY AUTO_INCREMENT,
    employee_id     INT,
    action          VARCHAR(100) NOT NULL,
    table_affected  VARCHAR(50),
    record_id       INT,
    action_time     DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip_address      VARCHAR(45),
    notes           VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Audit_Log (employee_id, action, table_affected, record_id, action_time, ip_address, notes) VALUES
(1, 'ACCOUNT_OPENED',     'Accounts',     6, '2021-04-28 09:15:00', '192.168.1.10', 'New salary account for Saba Nawaz'),
(2, 'LOAN_APPROVED',      'Loans',        1, '2023-01-01 10:00:00', '192.168.1.11', 'Personal loan approved for Ahmed Siddiqui'),
(4, 'ACCOUNT_UPDATED',    'Accounts',     3, '2022-08-15 11:30:00', '192.168.1.12', 'Business account limit increased'),
(5, 'SYSTEM_BACKUP',      NULL,           NULL,'2024-01-31 02:00:00','192.168.1.13', 'Monthly system backup completed'),
(6, 'CARD_BLOCKED',       'Cards',        5, '2024-02-20 14:00:00', '192.168.1.14', 'Card blocked on customer request'),
(1, 'CUSTOMER_UPDATED',   'Customers',    3, '2023-06-10 09:00:00', '192.168.1.10', 'Customer address updated'),
(3, 'FD_CREATED',         'Fixed_Deposits',5,'2024-01-01 10:30:00', '192.168.1.15', 'FD created for Tariq Mehmood'),
(7, 'LOAN_PAYMENT_POSTED','Loan_Payments', 6,'2024-02-01 08:00:00', '192.168.1.16', 'Auto-debit payment processed');


-- TABLE 15: NOTIFICATIONS
CREATE TABLE Notifications (
    notif_id        INT PRIMARY KEY AUTO_INCREMENT,
    customer_id     INT NOT NULL,
    notif_type      ENUM('SMS', 'Email', 'Push', 'In-App') NOT NULL,
    subject         VARCHAR(150),
    message         TEXT,
    sent_at         DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_read         BOOLEAN DEFAULT FALSE,
    related_txn_id  INT DEFAULT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (related_txn_id) REFERENCES Transactions(txn_id)
);

INSERT INTO Notifications (customer_id, notif_type, subject, message, sent_at, is_read, related_txn_id) VALUES
(1, 'SMS',   'Debit Alert',       'PKR 15,000 debited from ACC-1001-0001 on 10-Jan-2024. Balance: PKR 285,000.',           '2024-01-10 14:01:00', TRUE,  2),
(1, 'Email', 'Salary Credited',   'Your salary of PKR 50,000 has been credited to your account on 05-Jan-2024.',           '2024-01-05 10:31:00', TRUE,  1),
(2, 'Push',  'Transfer Complete', 'PKR 100,000 transferred successfully on 12-Jan-2024. Ref: REF-20240112-001.',           '2024-01-12 09:01:00', TRUE,  3),
(3, 'Email', 'Bill Payment',      'Your electricity bill of PKR 8,500 has been paid on 15-Jan-2024.',                     '2024-01-15 11:01:00', FALSE, 4),
(4, 'SMS',   'ATM Withdrawal',    'PKR 5,000 withdrawn via ATM on 18-Jan-2024. Balance: PKR 70,000.',                     '2024-01-18 16:01:00', TRUE,  5),
(5, 'In-App','Online Purchase',   'PKR 30,000 spent via online transaction on 01-Feb-2024.',                              '2024-02-01 10:01:00', FALSE, 6),
(6, 'SMS',   'IBFT Sent',         'PKR 20,000 transferred via IBFT to Meezan Bank on 05-Feb-2024.',                       '2024-02-05 13:01:00', TRUE,  7),
(7, 'Email', 'FD Reminder',       'Your Fixed Deposit FD-2024-0005 of PKR 300,000 matures on 01-Jan-2025.',               '2024-12-01 09:00:00', FALSE, NULL),
(8, 'Push',  'Low Balance Alert', 'Your account balance has dropped below PKR 100,000. Current balance: PKR 900,000.',    '2024-02-15 15:01:00', TRUE,  9),
(1, 'Email', 'Loan EMI Due',      'Your loan EMI of PKR 17,046 is due on 01-Apr-2024. Please ensure sufficient balance.',  '2024-03-25 08:00:00', FALSE, NULL);
