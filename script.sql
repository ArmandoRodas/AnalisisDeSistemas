-- CREATE DATABASE
CREATE DATABASE Banking;
GO

-- USE DATABASE
USE Banking;
GO

-- CREATE TABLE CENTRAL
CREATE TABLE Central (
    id_central INT PRIMARY KEY IDENTITY(1,1),
    name_central NVARCHAR(100) NOT NULL,
    address_central NVARCHAR(100) NOT NULL,
    phone_central NVARCHAR(20) NOT NULL,
    email_central NVARCHAR(100) NOT NULL,
    created_at_central DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at_central DATETIME NOT NULL DEFAULT GETDATE()
);

-- CREATE TABLE BRANCH
CREATE TABLE Branch (
    id_branch INT PRIMARY KEY IDENTITY(1,1),
    code_branch NVARCHAR(10) UNIQUE NOT NULL,
    name_branch NVARCHAR(100) NOT NULL,
    address_branch NVARCHAR(100) NOT NULL,
    phone_branch NVARCHAR(20) NOT NULL,
    email_branch NVARCHAR(100) NOT NULL,
    id_central_branch INT NOT NULL,
    created_at_branch DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at_branch DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_central_branch) REFERENCES Central(id_central) ON DELETE CASCADE
);

-- CREATE TABLE ATM
CREATE TABLE ATM (
    id_atm INT PRIMARY KEY IDENTITY(1,1),
    code_atm NVARCHAR(10) UNIQUE NOT NULL,
    name_atm NVARCHAR(100) NOT NULL,
    address_atm NVARCHAR(100) NOT NULL,
    phone_atm NVARCHAR(20) NOT NULL,
    email_atm NVARCHAR(100) NOT NULL,
    id_branch_atm INT NOT NULL,
    created_at_atm DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at_atm DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_branch_atm) REFERENCES Branch(id_branch) ON DELETE CASCADE
);

-- CREATE TABLE ACCOUNT HOLDER
CREATE TABLE Account_Holder (
    id_account_holder INT PRIMARY KEY IDENTITY(1,1),
    name_account_holder NVARCHAR(100) NOT NULL,
    address_account_holder NVARCHAR(100) NOT NULL,
    phone_account_holder NVARCHAR(20) NOT NULL,
    email_account_holder NVARCHAR(100) NOT NULL,
    created_at_account_holder DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at_account_holder DATETIME NOT NULL DEFAULT GETDATE()
);

-- CREATE TABLE ACCOUNT
CREATE TABLE Account (
    id_account INT PRIMARY KEY IDENTITY(1,1),
    number_account NVARCHAR(10) UNIQUE NOT NULL,
    type_account NVARCHAR(10) CHECK (type_account IN ('SAVINGS', 'CHECKING')), 
    currency_account NVARCHAR(10) CHECK (currency_account IN ('USD', 'GTQ')),
    balance_account DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    id_account_holder_account INT NOT NULL,
    id_branch_account INT NOT NULL,
    created_at_account DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at_account DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_account_holder_account) REFERENCES AccountHolder(id_account_holder) ON DELETE CASCADE,
    FOREIGN KEY (id_branch_account) REFERENCES Branch(id_branch) ON DELETE CASCADE
);

-- CREATE TABLE TRANSACTION
CREATE TABLE Transaction (
    id_transaction INT PRIMARY KEY IDENTITY(1,1),
    type_transaction NVARCHAR(10) CHECK (type_transaction IN ('DEPOSIT', 'WITHDRAWAL')),
    amount_transaction DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    id_account_transaction INT NOT NULL,
    id_atm_transaction INT NOT NULL,
    created_at_transaction DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at_transaction DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_account_transaction) REFERENCES Account(id_account) ON DELETE CASCADE,
    FOREIGN KEY (id_atm_transaction) REFERENCES ATM(id_atm) ON DELETE CASCADE
);
