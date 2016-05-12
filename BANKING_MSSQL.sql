/*BANKING - CREATING TABLES*/
use BANKING;


create if not exists table UserLogin (
	user_login_id varchar(100) not null,
	user_login_pwd varchar(100) not null,
	login_date_time datetime not null,
	logout_date_time datetime not null,
	user_profile_img image
);

--Insert 
CREATE TABLE BankPersons
  (
    person_id                  NUMERIC(15) CONSTRAINT person_pk PRIMARY KEY,
    person_first_name          VARCHAR(30),
    person_middle_name         VARCHAR(30),
    person_surname             VARCHAR(30),
    person_ssn                 numeric(30),
    person_dob                 DATE NOT NULL,
    person_sex					char(1),
	person_address1				VARCHAR(50),
    person_address2            VARCHAR(50),
    person_city                VARCHAR(50),
    person_country             VARCHAR(50),
    person_email               VARCHAR(25),
    person_phone               numeric(15),
    person_mobile              numeric(15)
  );
CREATE TABLE BankCompanies
  (
    company_id            numeric(7) CONSTRAINT company_pk PRIMARY KEY,
    company_name          VARCHAR(35),
    company_phone         numeric(15),
    company_email         VARCHAR(25),
    company_contact_title VARCHAR(35)
  );
CREATE TABLE BankAccountTypes
  (
    types_id          CHAR(2) CONSTRAINT account_types_pk PRIMARY KEY,
    types_name        VARCHAR(25),
    type_description VARCHAR(999),
	types_rate_change numeric(4,2)
  );
CREATE TABLE BankingLoans
  (
    loan_id           numeric(7) CONSTRAINT loan_id PRIMARY KEY,
    duration_by_month numeric(10),
    interest_rate     numeric(4),
    loan_start_date        DATE
  );
CREATE TABLE transactionTypes
  (
    transaction_type       CHAR(3) CONSTRAINT transaction_type_pk PRIMARY KEY,
    transaction_name       VARCHAR(25),
    transaction_descrition VARCHAR(999)
	);
  CREATE TABLE jobTitles
    (
      title_id          CHAR(3) CONSTRAINT job_title_pk PRIMARY KEY,
      title_name        VARCHAR(25),
      title_description VARCHAR(250)
    );
  CREATE TABLE emails
    (
      email_id    numeric(13) CONSTRAINT email_pk PRIMARY KEY,
      email_title VARCHAR(50),
      email_body  VARCHAR(999),
    );
  CREATE TABLE emailTracking
    (
      email_id          numeric(13) CONSTRAINT email_tracking_pk PRIMARY KEY,
      email_sender_id   numeric(7),
      email_receiver_id numeric(7),
      email_is_read     CHAR(1)
    );
  CREATE TABLE BankCustomers
    (
      customer_id numeric(7) CONSTRAINT customer_pk PRIMARY KEY,
      --FOREIGN KEY CONSTRAINTS.--
      person_id_fk  numeric(15) CONSTRAINT person_fk REFERENCES BankPersons(person_id),
      company_id_fk numeric(7) CONSTRAINT company_fk REFERENCES BankCompanies(company_id),
      customer_type CHAR(1)
    );
  CREATE TABLE Branches
    (
      branch_id      numeric(3) CONSTRAINT bank_branch_pk PRIMARY KEY,
      branch_name    VARCHAR(15),
      branch_city    VARCHAR(35),
      branch_country VARCHAR(35),
	  branch_phone numeric(15)
    );
  CREATE TABLE BankAccounts
    (
      account_id      numeric(7) /*CONSTRAINT account_pk PRIMARY KEY*/,
      branch_id_fk    numeric(3) CONSTRAINT branch_fk REFERENCES Branches(branch_id),
      customer_id_fk  numeric(7) CONSTRAINT customer_fk REFERENCES BankCustomers(customer_id),
      acc_type_fk     CHAR(2)	 CONSTRAINT account_type_fk REFERENCES BankAccountTypes(types_id),
      account_balance numeric(38,2),
      account_rate    numeric(9,2),
      account_status  VARCHAR(15),
	  constraint accounts_composite_pk primary key(account_id,branch_id_fk, customer_id_fk)
    );
  CREATE TABLE department
    (
      department_id   CHAR(3) CONSTRAINT department_pk PRIMARY KEY,
      department_name VARCHAR(25)
    );
  CREATE TABLE BankEmployees
    (
      employee_id numeric(7) CONSTRAINT employee_pk PRIMARY KEY,
      --foreign key constrainsts.
      persons_id_fk numeric(15) CONSTRAINT persons_fk REFERENCES BankPersons(person_id),
      branch_id_fk  numeric(3) CONSTRAINT employees_fk REFERENCES Branches(branch_id),
      title_id_fk   CHAR(3) CONSTRAINT job_title_fk REFERENCES jobTitles(title_id),
      department_fk CHAR(3) CONSTRAINT departments_fk REFERENCES department(department_id),
      manager_id    numeric(7) CONSTRAINT emp_manager_fk REFERENCES BankEmployees(employee_id),
      ----------------------
      employee_salary      numeric(9,2),
      employee_hourly_rate numeric(9,2),
      employee_level       numeric(2),
      employee_pwd         VARCHAR(100)
    );
  CREATE TABLE BankTransactions
    (
      transaction_id   numeric(7)  ,
      transaction_date DATE,
      transaction_time TIME,
      account_fk       numeric(7) CONSTRAINT account_fk REFERENCES BankAccounts(account_id),
      transaction_type CHAR(3) CONSTRAINT transaction_type_fk REFERENCES transactionTypes(transaction_type),
      loan_fk          numeric(7) CONSTRAINT loan_fk REFERENCES BankingLoans(loan_id),
      employee_fk      numeric(7) CONSTRAINT employee_fk REFERENCES BankEmployees(employee_id),
      credit_debit     CHAR(1),
      CONSTRAINT transaction_pk PRIMARY KEY(transaction_id,transaction_date,transaction_time),
    );