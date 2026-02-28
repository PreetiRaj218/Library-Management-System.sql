DROP DATABASE IF EXISTS Books;
CREATE DATABASE Books;
USE Books;

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150),
    author VARCHAR(100),
    genre VARCHAR(50),
    published_year INT,
    total_copies INT,
    available_copies INT
);

CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    join_date DATE
);

CREATE TABLE Borrow_Records (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    due_date DATE,
    return_date DATE,
    fine_amount DECIMAL(8,2) DEFAULT 0,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Books (title, author, genre, published_year, total_copies, available_copies) VALUES
('The Alchemist', 'Paulo Coelho', 'Fiction', 1988, 10, 8),
('Atomic Habits', 'James Clear', 'Self-Help', 2018, 7, 5),
('Clean Code', 'Robert C. Martin', 'Programming', 2008, 5, 3),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 1937, 6, 4);

INSERT INTO Members (first_name, last_name, email, join_date) VALUES
('John', 'Doe', 'john@example.com', '2024-01-10'),
('Alice', 'Smith', 'alice@example.com', '2024-02-05'),
('Robert', 'Brown', 'robert@example.com', '2024-03-15');

INSERT INTO Borrow_Records (member_id, book_id, borrow_date, due_date, return_date) VALUES
(1, 1, '2024-05-01', '2024-05-15', '2024-05-14'),
(2, 2, '2024-05-10', '2024-05-24', NULL),
(1, 3, '2024-06-01', '2024-06-15', '2024-06-20'),
(3, 1, '2024-06-05', '2024-06-19', NULL);

SELECT * FROM Members;
SELECT * FROM Borrow_Records;



-- Most Borrowed Book

SELECT 
    b.title,
    COUNT(br.borrow_id) AS times_borrowed
FROM Borrow_Records br
JOIN Books b ON br.book_id = b.book_id
GROUP BY b.title
ORDER BY times_borrowed DESC;


-- Currently Borrowed Books
SELECT 
    m.first_name,
    b.title,
    br.borrow_date,
    br.due_date
FROM Borrow_Records br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE br.return_date IS NULL;

-- Overdue Books
SELECT 
    m.first_name,
    b.title,
    br.due_date,
    DATEDIFF(CURDATE(), br.due_date) AS days_overdue
FROM Borrow_Records br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE br.return_date IS NULL
AND br.due_date < CURDATE();

-- Trigger: Reduce Available Copies After Borrow
CREATE TRIGGER decrease_book_stock
AFTER INSERT ON Borrow_Records
FOR EACH ROW
UPDATE Books
SET available_copies = available_copies - 1
WHERE book_id = NEW.book_id;


SELECT b.title, COUNT(*) AS borrow_count
FROM Borrow_Records br
JOIN Books b ON br.book_id = b.book_id
GROUP BY b.title
ORDER BY borrow_count DESC;


SELECT m.first_name, b.title, br.due_date
FROM Borrow_Records br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE br.return_date IS NULL
AND br.due_date < CURDATE();


