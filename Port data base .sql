create table deposit(
Account_no VARCHAR(30),
Cust_name VARCHAR(30),
amount INT,
branch VARCHAR(30)
);

CREATE TABLE Customer(
cust_id VARCHAR(30),
Cust_name VARCHAR(30),
Cust_city VARCHAR(30)
);

CREATE TABLE sailors(
sname VARCHAR(30),
Ranking INT,
travel_date DATE
);

CREATE TABLE boats(
bname VARCHAR(30),
colour VARCHAR(30)
);

CREATE TABLE employee(
emp_name VARCHAR(30),
address VARCHAR(30),
city VARCHAR(30)
);

CREATE TABLE product(
product_name VARCHAR(30),
price INT 
);

CREATE TABLE loans(
loan_no VARCHAR(30),
Cust_no VARCHAR(30),
amount INT
);
CREATE TABLE shares(
shares_list VARCHAR(30),
shares int
);


show tables;
desc TABLE deposit;

insert INTO deposit VALUES
('A01','RAVI',50000,'VISHAKAPATAM'),
('A02','SRIKUMAR',50000,'VISHAKAPATAM'),
('A03','UTTEJ',50000,'VISHAKAPATAM');

insert INTO customer VALUES
('C01','RAVI','VISHAKAPATAM'),
('C02','SRIKUMAR','VISHAKAPATAM'),
('C03','UTTEJ','VISHAKAPATAM');

insert INTO sailors VALUES
('MOHAN BABU',5,'2025-06-01'),
('VISHNU',5,'2025-07-01'),
('MONAJ',5,'2025-06-08');

insert INTO boats VALUES
('SEAZE THE BOAT','RED'),
('CMA','BLUE'),
('Shipping Corporation of India','GREEN');

insert INTO employee VALUES
('ANIL','PATEL STREET','VISHAKAPATAM'),
('VASU','AKKAIYAPALLEM','VISHAKAPATAM'),
('SUJEET','RK BEACH ROAD','VISHAKAPATAM');

insert INTO product VALUES
('RICE','1200'),
('MUSTANG CARS','12000000'),
('TOBACOO','3000000');

insert INTO loans VALUES
('L1','HARSHA','300000'),
('L2','ANATH','400000');

insert INTO shares VALUES
('d1','200000'),
('d2','300000');

desc deposit;
desc product;
desc shares;

SELECT* FROM deposit;
SELECT* FROM customer;
SELECT* FROM shares;





