SET SERVEROUTPUT ON;

-- Drop tables if they exist
DROP TABLE Reviews;
DROP TABLE Recommendations;   
DROP TABLE Invoices;
DROP TABLE Credit_Card;
DROP TABLE Orders;
DROP TABLE Products;
DROP TABLE Product_Categories;
DROP TABLE Customers;

-- Create Customers table
CREATE TABLE Customers (
  Customer_ID INT PRIMARY KEY,
  fname VARCHAR(50),
  lname VARCHAR(50),
  email VARCHAR(50),
  city VARCHAR(50),
  state VARCHAR(50),
  zip VARCHAR2(5)
);

-- Create Product Categories table
CREATE TABLE Product_Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    description VARCHAR(150)
);

-- Create Products table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    product_name VARCHAR(30), 
    quantity NUMBER(10) CONSTRAINT Valid_Quantity_Check CHECK (quantity > 0),
    unit_price FLOAT(30),
    category_id INT NOT NULL,
    FOREIGN KEY (category_ID) REFERENCES Product_Categories(category_id) 
);  

-- Create Orders table
CREATE TABLE Orders ( 
 OrderID INT PRIMARY KEY,
 Customer_ID INT,
 Product_ID INT,
 quantity INT,
 orderdate DATE,
 FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
 FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Create Credit Card table
CREATE TABLE Credit_Card (
    Credit_Card# INT PRIMARY KEY,
    expiration_year INT,
    expiration_month INT,
    Credit_Card_Type VARCHAR(30),
    Customer_ID INT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Create Invoices table
CREATE TABLE Invoices (
    invoiceID INT PRIMARY KEY, 
    orderID INT,
    Customer_ID INT, 
    creditcard# NUMBER,
    amount NUMBER, 
    FOREIGN KEY (orderID) REFERENCES Orders(orderID), 
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID), 
    FOREIGN KEY (creditcard#) REFERENCES Credit_Card(Credit_Card#)
);

-- Create Recommendations table
CREATE TABLE Recommendations (
    Recommendation_ID INT PRIMARY KEY,
    Customer_ID INT,
    Recommended_Product_ID INT, 
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Recommended_Product_ID) REFERENCES Products(Product_ID)
);

-- Create Reviews table
CREATE TABLE Reviews (
    Review_ID INT PRIMARY KEY,
    Product_ID INT, 
    Reviewer_email VARCHAR(30), 
    Stars_Given VARCHAR(5), 
    Review_text VARCHAR(100),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Procedures and Functions

-- Procedure: Add_Customer
CREATE OR REPLACE PROCEDURE Add_Customer(
  s_customer_id IN NUMBER,
  s_fname IN VARCHAR2,
  s_lname IN VARCHAR2,
  s_email IN VARCHAR2,
  s_city IN VARCHAR2,
  s_state IN VARCHAR2,
  s_zip IN VARCHAR2
) IS
BEGIN
  INSERT INTO Customers(Customer_ID, fname, lname, email, city, state, zip)
  VALUES(s_customer_id, s_fname, s_lname, s_email, s_city, s_state, s_zip);
END;
/

-- Sequence: ID Sequence
DROP SEQUENCE Id_seq;
CREATE SEQUENCE Id_seq START WITH 1 INCREMENT BY 1;

-- Insert Sample Customers
BEGIN
  ADD_CUSTOMER(Id_seq.nextval, 'John', 'Smith', 'john@smith.com', 'Baltimore', 'MD', '21250');
  ADD_CUSTOMER(Id_seq.nextval, 'Mary', 'Smith', 'mary@smith.com', 'Baltimore', 'MD', '21250');
  ADD_CUSTOMER(Id_seq.nextval, 'Pat', 'Wagner', 'pat@wagner.com', 'Baltimore', 'MD', '21250');
  ADD_CUSTOMER(Id_seq.nextval, 'Rajeev', 'Kumar', 'rajeev@kumar.org', 'Columbia', 'SC', '44250');
  ADD_CUSTOMER(Id_seq.nextval, 'Mary', 'Poppins', 'mary@poppins.com', 'New York', 'NY', '12345');
  ADD_CUSTOMER(Id_seq.nextval, 'Joe', 'Poppins', 'joe@poppins.com', 'New York', 'NY', '12345');
END;
/

-- More procedures and triggers are defined in the complete script...

-- Final SELECT Queries
SELECT * FROM Customers;
SELECT * FROM Product_Categories;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Credit_Card;
SELECT * FROM Invoices;
SELECT * FROM Recommendations;
SELECT * FROM Reviews;
