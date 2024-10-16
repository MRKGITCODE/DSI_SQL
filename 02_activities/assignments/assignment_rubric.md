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

    Employee

Columns:
Employee_ID (Primary Key)
First_Name
Last_Name
Position
Hire_Date
Order

Columns:
Order_ID (Primary Key)
Order_Date
Customer_ID (Foreign Key)
Total_Amount
Sales

Columns:
Sales_ID (Primary Key)
Order_ID (Foreign Key)
Employee_ID (Foreign Key)
Sale_Amount
Customer

Columns:
Customer_ID (Primary Key)
First_Name
Last_Name
Email
Phone
Book

Columns:
Book_ID (Primary Key)
Title
Author
Price
Stock_Quantity

diagram  :  1 . ![alt text](<QA 1 .drawio.png>)

diagram 2 ; ![alt text](<erd 2.png>)

  - **Tables Exist**: All five tables need to exist.
  - **Column Relevance**: Each table must have named columns that relate to their respective entities and include columns relevant for bookstore administration. (**🚨EACH table will be graded as complete or incomplete🚨**)
  - **Relationships Indicated**: Clear relationships between the aforementioned tables must be established.
  - **Date Table**: 
    - Must exist with typical columns.
    - Must have correct relationships with other relevant tables indicated.

## Question 2
- Employee Shift Table exists, and we can discern morning/evening shifts from its design**

Column Name	Data Type	Description
Shift_ID	INT	Primary Key that uniquely identifies each shift.
Employee_ID	INT	Foreign Key linking to the Employee table.
Shift_Start	DATETIME	The start time of the shift ( 08:00:00 for a morning shift).
Shift_End	DATETIME	The end time of the shift ( 16:00:00 for a morning shift).
Shift_Type	STRING	Indicates the type of shift ( "Morning" or "Evening").
Date	DATE	The date on which the shift occurs.
Example Data
Shift_ID	Employee_ID	Shift_Start	Shift_End	Shift_Type	Date
1	101	08:00:00	16:00:00	Morning	2024-10-01
2	102	16:00:00	00:00:00	Evening	2024-10-01
3	103	08:00:00	16:00:00	Morning	2024-10-02
4	104	16:00:00	00:00:00	Evening	2024-10-02

SELECT e.First_Name, e.Last_Name, s.Shift_Type, s.Shift_Start, s.Shift_End
FROM Employee e
JOIN Employee_Shift s ON e.Employee_ID = s.Employee_ID
ORDER BY s.Date, s.Shift_Start;

SELECT s.Shift_Type, COUNT(s.Shift_ID) AS Shift_Count
FROM Employee_Shift s
GROUP BY s.Shift_Type;

SELECT e.First_Name, e.Last_Name
FROM Employee e
JOIN Employee_Shift s ON e.Employee_ID = s.Employee_ID
WHERE s.Shift_Type = 'Morning' AND s.Date = '2024-10-01';

## Question 3: 
- **Two distinct architectures are proposed**
- **One design for Customer Addresses table would retain changes**
- **One design for Customer Addresses table would overwrite changes**
- **Each architecture is properly labelled as either Type 1 or Type 2 SCD**
    - Both Correct (Complete)
    - One Wrong (Incomplete)
    - Both Wrong (Incomplete)

## Question 4: 
- **AdventureWorks ERD has been examined**
- **Two interesting differences between participant ERDs and AdventureWorks ERDs highlighted**
- **Student reflection on differences between the ERDs**

## Criteria

|Criteria|Complete|Incomplete|
|--------|----|----|
|Question 1 Requirements|All requirements are met.|At least one requirement is not met.|
|Question 2 Requirements|All requirements are met.|At least one requirement is not met.|
|Question 3 Requirements|All requirements are met.|At least one requirement is not met.|
|Question 4 Requirements|All requirements are met.|At least one requirement is not met.|
