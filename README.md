# Library-Management-System.sql
This project is a Library Management System built using SQL. It manages books, members, and borrow history while tracking overdue books and fines.
🎯 Objectives

Manage book inventory

Track member registrations

Record borrow & return history

Identify overdue books

Calculate fines

Analyze most borrowed books

🗄️ Database Schema
📖 Books Table

book_id (Primary Key)

title

author

genre

published_year

total_copies

available_copies

👤 Members Table

member_id (Primary Key)

first_name

last_name

email

join_date

🔄 Borrow_Records Table

borrow_id (Primary Key)

member_id (Foreign Key)

book_id (Foreign Key)

borrow_date

due_date

return_date

fine_amount

🔗 Relationships

One Member → Many Borrow Records

One Book → Many Borrow Records

Borrow_Records connects Members and Books



📊 Key SQL Features Used

Joins

Group By

Aggregate Functions

Date Functions

Subqueries

Triggers

Foreign Keys

Indexing
