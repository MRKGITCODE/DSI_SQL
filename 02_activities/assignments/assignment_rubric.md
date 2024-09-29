# Assignment 1: Design a Logical Model Rubric

## General
  - Criteria: Participant Name on Assignment
  - Criteria: Written content is no longer than two pages
  - Criteria: Assignment is free of noticeable typos
  - Criteria: Two ERDs exist

## Question 1

  - **Tables**
    - Employee: Relates to employees.
    - Order: Relates to order processing.
    - Sales: Relates to sales transactions.
    - Customer: Relates to customer information.
    - Book: Relates to inventory of books.

  - **Tables Exist**: All five tables need to exist.
  - **Column Relevance**: Each table must have named columns that relate to their respective entities and include columns relevant for bookstore administration. (**🚨EACH table will be graded as complete or incomplete🚨**)
  - **Relationships Indicated**: Clear relationships between the aforementioned tables must be established.
  - **Date Table**: 
    - Must exist with typical columns.
    - Must have correct relationships with other relevant tables indicated.
   I AM CREATING THE FOLLOWING DATABASE SCHEMA BASED ON THE REQUIRMENTS FOR A BOOK STORE 

1. Employee Table:

Column Name	Data Type	Description
EmployeeID	INT (PK)	Unique identifier for each employee
FirstName	VARCHAR	Employee's first name
LastName	VARCHAR	Employee's last name
Role	VARCHAR	Job role (e.g., cashier, manager)
HireDate	DATE	Date when the employee was hired
Salary	DECIMAL	Employee's salary
ContactNumber	VARCHAR	Employee contact informationerDiagram

2. Order Table:

Column Name	Data Type	Description
OrderID	INT (PK)	Unique identifier for each order
CustomerID	INT (FK)	Links to the Customer table
EmployeeID	INT (FK)	Links to the Employee table
BookID	INT (FK)	Links to the Book table
OrderDate	DATE	Date the order was placed
Quantity	INT	Number of books ordered
3. Sales Table:

Column Name	Data Type	Description
SalesID	INT (PK)	Unique identifier for each sales transaction
OrderID	INT (FK)	Links to the Order table
SaleDate	DATE	Date when the sale was completed
PaymentMethod	VARCHAR	Payment method (e.g., credit card, cash)
Amount	DECIMAL	Total amount of the sale
4. Customer Table:

Column Name	Data Type	Description
CustomerID	INT (PK)	Unique identifier for each customer
FirstName	VARCHAR	Customer's first name
LastName	VARCHAR	Customer's last name
Email	VARCHAR	Customer's email
Phone	VARCHAR	Customer's contact number
Address	VARCHAR	Customer's address
5. Book Table:

Column Name	Data Type	Description
BookID	INT (PK)	Unique identifier for each book
Title	VARCHAR	Title of the book
Author	VARCHAR	Author of the book
Genre	VARCHAR	Genre of the book
Price	DECIMAL	Price of the book
StockQuantity	INT	Quantity of the book in stock
6. Date Table:

Column Name	Data Type	Description
DateID	INT (PK)	Unique identifier for the date
Date	DATE	Full date (YYYY-MM-DD)
Year	INT	Year part of the date
Month	INT	Month part of the date
Day	INT	Day part of the date
DayOfWeek	VARCHAR	Day of the week (e.g., Monday)
Relationships:
Employee Table:

One-to-many relationship with the Order table. (One employee can process multiple orders)
Order Table:

Many-to-one relationship with Customer table. (A customer can place multiple orders)
Many-to-one relationship with Book table. (Each order contains one book, but this could be modified for a more complex order system)
Many-to-one relationship with Date table. (Each order is placed on a specific date)
Sales Table:

Many-to-one relationship with the Order table. (One order can lead to one sales transaction)
Many-to-one relationship with the Date table. (Each sale occurs on a specific date)
Date Table:

The Date table connects to the Order and Sales tables through the OrderDate and SaleDate fields, respectively.
This schema provides a clear structure and relationships between all the tables.

## Question 2
- Employee Shift Table exists, and we can discern morning/evening shifts from its design**

To CREATE  the Employee Shift table that distinguishes between morning and evening shifts, we can design the table as follows:
Employee Shift Table:
Column Name	Data Type	Description
ShiftID	INT (PK)	Unique identifier for each shift
EmployeeID	INT (FK)	Links to the Employee table
ShiftDate	DATE	Date of the shift
ShiftType	VARCHAR	Type of shift (e.g., 'Morning', 'Evening')
StartTime	TIME	Shift start time
EndTime	TIME	Shift end time
Key Points:
EmployeeID is a foreign key linking to the Employee table, establishing which employee worked a particular shift.
ShiftType clearly indicates whether the shift is a morning or evening shift.
StartTime and EndTime define the specific working hours for that shift.

## Question 3: 
- **Two distinct architectures are proposed**
- **One design for Customer Addresses table would retain changes**
- **One design for Customer Addresses table would overwrite changes**
- **Each architecture is properly labelled as either Type 1 or Type 2 SCD**
    - Both Correct (Complete)
    - One Wrong (Incomplete)
    - Both Wrong (Incomplete)

Two distinct architectures for the Customer Addresses table, one that retains changes (Type 2 Slowly Changing Dimension) and one that overwrites changes (Type 1 Slowly Changing Dimension), we can design both architectures as follows:

Design 1: Type 1 SCD (Overwrites Changes)
In Type 1 SCD, any changes to customer addresses overwrite the previous data, meaning no history is kept.

Customer Addresses Table (Type 1 SCD)
Column Name	Data Type	Description
CustomerID	INT (PK)	Unique identifier for the customer
AddressLine1	VARCHAR	Primary address
AddressLine2	VARCHAR	Secondary address (optional)
City	VARCHAR	City of the customer
State	VARCHAR	State of the customer
PostalCode	VARCHAR	Postal code
Country	VARCHAR	Country of the customer
LastUpdated	TIMESTAMP	Last updated date and time
How it works: Whenever a customer’s address changes, the existing address data is simply updated, and no previous data is retained.
Pros: Simplifies storage and queries.
Cons: No historical data on address changes is retained.
Design 2: Type 2 SCD (Retains Changes)
In Type 2 SCD, changes to customer addresses are retained by adding new rows for every change, so a history of all address changes is maintained.

Customer Addresses Table (Type 2 SCD)
Column Name	Data Type	Description
CustomerID	INT (FK)	Unique identifier for the customer
AddressID	INT (PK)	Unique identifier for the address entry
AddressLine1	VARCHAR	Primary address
AddressLine2	VARCHAR	Secondary address (optional)
City	VARCHAR	City of the customer
State	VARCHAR	State of the customer
PostalCode	VARCHAR	Postal code
Country	VARCHAR	Country of the customer
StartDate	DATE	Date when this address became active
EndDate	DATE	Date when this address became inactive (NULL if current)
How it works: When a customer’s address changes, a new row is added with the new address, and the previous address is "closed" by setting its EndDate.
Pros: Full history of address changes is preserved.
Cons: Requires more storage and can make queries more complex.
Labeling and Summary:
Type 1 SCD: Overwrites changes and does not retain historical data.
Type 2 SCD: Retains changes and keeps a record of all historical data.
Both designs are correct and complete, fulfilling the requirement for the two distinct architectures.

## Question 4: 
- **AdventureWorks ERD has been examined**
- **Two interesting differences between participant ERDs and AdventureWorks ERDs highlighted**
- **Student reflection on differences between the ERDs**

Two interesting differences between these ERDs and provide a student reflection on these differences.

Difference 1: Normalization and Entity Granularity
AdventureWorks ERD: The AdventureWorks database has a high level of normalization with a significant number of entities and relationships. Each aspect of the business is captured in detail, leading to a larger number of tables. For example, there are separate tables for Person, Address, and Contact, which represent distinct entities for efficient and modular data storage.

Participant's ERD: Depending on the context, the participant’s ERD might have fewer entities, combining related attributes into a single table. For instance, a bookshop database might store customer details like CustomerID, Address, and Contact in one Customer table rather than splitting them into multiple entities as in AdventureWorks.

Reflection:
Normalization can lead to complex ERDs in large organizations, where data integrity and storage efficiency are priorities. In smaller systems, simplicity and fewer relationships might make the ERD easier to manage. The choice of normalization depends on the scale and needs of the database. As a student, understanding how to balance normalization with usability is crucial. In simpler projects, denormalization may be more practical, but in larger projects, granular entity design aids in scalability.

## Criteria

|Criteria|Complete|Incomplete|
|--------|----|----|
|Question 1 Requirements|All requirements are met.|At least one requirement is not met.|
|Question 2 Requirements|All requirements are met.|At least one requirement is not met.|
|Question 3 Requirements|All requirements are met.|At least one requirement is not met.|
|Question 4 Requirements|All requirements are met.|At least one requirement is not met.|
