
--1. Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”.

IF NOT EXISTS (
    SELECT name 
    FROM sys.databases 
    WHERE name = N'Career_Hub2' 
)
BEGIN
    CREATE DATABASE Career_Hub2;
    PRINT 'Database Career_Hub created successfully';
END

ELSE

BEGIN
    PRINT 'Database Career_Hub already exists';
END;

use career_hub2;

--============================================================================================================

--2.Create tables for Companies, Jobs, Applicants and Applications.
--3. Define appropriate primary keys, foreign keys, and constraints. 
--4. Ensure the script handles potential errors, such as if the database or tables already exist.


--companies

IF NOT EXISTS (
    SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'companies') AND type = N'U'
)
BEGIN
    CREATE TABLE companies(
        companyId INT PRIMARY KEY,
        companyName VARCHAR(100) NOT NULL,
        location VARCHAR(100) NOT NULL
    );
    PRINT 'Table companies created successfully';
END
ELSE
BEGIN
    PRINT 'Table companies already exists';
END;


--jobs
IF NOT EXISTS (
    SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'jobs') AND type = N'U'
)
BEGIN
    CREATE TABLE jobs(
        jobId INT PRIMARY KEY,
        companyId INT,
        jobTitle VARCHAR(100) NOT NULL,
        jobDescription VARCHAR(MAX) NOT NULL,
        jobLocation VARCHAR(100) NOT NULL,
        salary DECIMAL(15,2) NOT NULL,
        jobType VARCHAR(30) NOT NULL,
        postedDate DATETIME NOT NULL,

        CONSTRAINT FK_companies FOREIGN KEY (companyId) REFERENCES companies(companyId),
        CONSTRAINT check_jobType CHECK (jobType IN ('Full-time', 'Part-time', 'contract'))
    );
    PRINT 'Table jobs created successfully';
END
ELSE
BEGIN
    PRINT 'Table jobs already exists';
END;


--applicants
IF NOT EXISTS (
    SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'applicants') AND type = N'U'
)
BEGIN
    CREATE TABLE applicants(
        applicantId INT PRIMARY KEY,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL,
        phone VARCHAR(10) NOT NULL,
        resume VARCHAR(MAX) NOT NULL
    );
    PRINT 'Table applicants created successfully';
END
ELSE
BEGIN
    PRINT 'Table applicants already exists';
END;


--applicantions
IF NOT EXISTS (
    SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'applications') AND type = N'U'
)
BEGIN
    CREATE TABLE applications(
        applicationId INT PRIMARY KEY,
        jobID INT,
        applicantId INT,
        applicationtime DATETIME NOT NULL,
        coverLetter VARCHAR(MAX) NOT NULL,

        CONSTRAINT FK_jobs FOREIGN KEY (jobID) REFERENCES jobs(jobID),
        CONSTRAINT FK_applicants FOREIGN KEY (applicantId) REFERENCES applicants(applicantId)
    );
    PRINT 'Table applications created successfully';
END
ELSE
BEGIN
    PRINT 'Table applications already exists';
END;


--============================================================================================================

--companies
INSERT INTO companies (companyId, companyName, location) VALUES
(1, 'Tech Innovators', 'New York'),
(2, 'Creative Solutions', 'San Francisco'),
(3, 'Global Corp', 'London'),
(4, 'Smart Systems', 'Berlin'),
(5, 'Eco Enterprises', 'Tokyo'),
(6, 'HealthFirst', 'Los Angeles'),
(7, 'Finance Hub', 'Chicago'),
(8, 'EduSoft', 'Boston'),
(9, 'Retail Experts', 'Dallas'),
(10, 'GreenTech', 'Seattle'),
(11, 'Market Leaders', 'Toronto'),
(12, 'Transport Inc.', 'Mumbai'),
(13, 'MediaWorks', 'Paris'),
(14, 'AI Pioneers', 'Singapore'),
(15, 'Bio Innovations', 'Zurich'),
(16, 'Energy Systems', 'Houston'),
(17, 'WebSolutions', 'Sydney'),
(18, 'NextGen Robotics', 'Austin'),
(19, 'FoodTech', 'Vancouver'),
(20, 'Space Ventures', 'Dubai');

-- Jobs 
INSERT INTO jobs (jobId, companyId, jobTitle, jobDescription, jobLocation, salary, jobType, postedDate) VALUES
(1, 1, 'Software Engineer', 'Develop and maintain software systems', 'New York', 120000.00, 'Full-time', GETDATE()),
(2, 2, 'Product Manager', 'Oversee product development lifecycle', 'San Francisco', 135000.00, 'Full-time', GETDATE()),
(3, 3, 'Software Engineer', 'Develop and maintain software systems', 'London', 115000.00, 'Full-time', GETDATE()), -- Same job title
(4, 4, 'DevOps Engineer', 'Manage infrastructure and deployments', 'Berlin', 110000.00, 'Full-time', GETDATE()),
(5, 5, 'Marketing Specialist', 'Execute marketing strategies and campaigns', 'Tokyo', 95000.00, 'Full-time', GETDATE()),
(6, 6, 'Business Analyst', 'Analyze business processes and recommend solutions', 'Los Angeles', 105000.00, 'Full-time', GETDATE()),
(7, 7, 'Financial Analyst', 'Analyze financial data and provide insights', 'Chicago', 100000.00, 'Full-time', GETDATE()),
(8, 8, 'Product Manager', 'Oversee product development lifecycle', 'Boston', 85000.00, 'Full-time', GETDATE()), -- Same job title
(9, 9, 'Retail Manager', 'Manage retail store operations', 'Dallas', 90000.00, 'Full-time', GETDATE()),
(10, 10, 'Sustainability Consultant', 'Advise on sustainable business practices', 'Seattle', 95000.00, 'Full-time', GETDATE()),
(11, 11, 'Financial Analyst', 'Analyze financial data and provide insights', 'Toronto', 95000.00, 'Full-time', GETDATE()), -- Same job title
(12, 12, 'Supply Chain Manager', 'Oversee supply chain logistics', 'Mumbai', 100000.00, 'Full-time', GETDATE()),
(13, 13, 'Content Creator', 'Develop engaging content for digital media', 'Paris', 80000.00, 'Full-time', GETDATE()),
(14, 14, 'AI Researcher', 'Research and develop AI algorithms', 'Singapore', 150000.00, 'Full-time', GETDATE()),
(15, 15, 'Biochemist', 'Conduct research on biochemical processes', 'Zurich', 125000.00, 'Full-time', GETDATE()),
(16, 16, 'Energy Analyst', 'Analyze energy consumption and advise on improvements', 'Houston', 110000.00, 'Full-time', GETDATE()),
(17, 17, 'Web Developer', 'Build and maintain websites', 'Sydney', 95000.00, 'Full-time', GETDATE()),
(18, 18, 'Robotics Engineer', 'Design and develop robotic systems', 'Austin', 135000.00, 'Full-time', GETDATE()),
(19, 19, 'Food Scientist', 'Research and develop food products', 'Vancouver', 115000.00, 'Full-time', GETDATE()),
(20, 20, 'Sustainability Consultant', 'Advise on sustainable business practices', 'Dubai', 140000.00, 'Full-time', GETDATE()); -- Same job title


INSERT INTO jobs (jobId, companyId, jobTitle, jobDescription, jobLocation, salary, jobType, postedDate) VALUES
(21, 1, 'Lead Software Engineer', 'Oversee the software development team', 'New York', 0.00, 'Full-time', GETDATE()),  -- Salary 0
(22, 2, 'Mobile Application Developer', 'Develop software for mobile platforms', 'San Francisco', 90000.00, 'Full-time', GETDATE()),
(23, 3, 'Business Intelligence Analyst', 'Analyze data to improve business decisions', 'London', 0.00, 'Full-time', GETDATE()),  -- Salary 0
(24, 4, 'Digital Marketing Specialist', 'Implement online marketing strategies', 'Berlin', 80000.00, 'Full-time', GETDATE()),
(25, 5, 'Software Solutions Architect', 'Design software solutions for clients', 'Tokyo', 95000.00, 'Full-time', GETDATE()),
(26, 6, 'Junior Financial Analyst', 'Assist in financial reporting and analysis', 'Los Angeles', 0.00, 'Full-time', GETDATE()),  -- Salary 0
(27, 7, 'Senior Software Engineer', 'Develop high-performance software applications', 'Chicago', 85000.00, 'Full-time', GETDATE()),
(28, 8, 'Product Development Manager', 'Manage the development of new products', 'Boston', 120000.00, 'Full-time', GETDATE()),
(29, 9, 'Market Research Analyst', 'Conduct research to guide marketing strategies', 'Dallas', 70000.00, 'Full-time', GETDATE()),
(30, 10, 'Front-End Web Developer', 'Build responsive and user-friendly web interfaces', 'Seattle', 90000.00, 'Full-time', GETDATE());


INSERT INTO jobs (jobId, companyId, jobTitle, jobDescription, jobLocation, salary, jobType, postedDate) VALUES
(31, 1, 'Software Quality Assurance Engineer', 'Ensure the quality of software products through testing.', 'New York', 75000.00, 'Full-time', GETDATE()),
(32, 1, 'Technical Support Specialist', 'Provide technical support and assistance to clients.', 'New York', 60000.00, 'Full-time', GETDATE()),
(33, 3, 'Cloud Solutions Architect', 'Design and implement cloud-based solutions for clients.', 'London', 125000.00, 'Full-time', GETDATE()),
(34, 4, 'UI/UX Designer', 'Design user-friendly interfaces and improve user experience.', 'Berlin', 85000.00, 'Full-time', GETDATE()),
(35, 5, 'Sales Executive', 'Drive sales and build relationships with clients.', 'Tokyo', 90000.00, 'Full-time', GETDATE());

-- Applicants 
INSERT INTO applicants (applicantId, first_name, last_name, email, phone, resume) VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '1234567890', 'Resume content here'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '0987654321', 'Resume content here'),
(3, 'Michael', 'Johnson', 'michaelj@example.com', '1122334455', 'Resume content here'),
(4, 'Emily', 'Davis', 'emilyd@example.com', '5566778899', 'Resume content here'),
(5, 'Chris', 'Brown', 'chrisb@example.com', '6677889900', 'Resume content here'),
(6, 'Sarah', 'Wilson', 'sarahw@example.com', '7788990011', 'Resume content here'),
(7, 'James', 'Taylor', 'jamest@example.com', '8899001122', 'Resume content here'),
(8, 'David', 'Anderson', 'davidand@example.com', '9900112233', 'Resume content here'),
(9, 'Laura', 'Martin', 'lauram@example.com', '0112233445', 'Resume content here'),
(10, 'Robert', 'Moore', 'robertm@example.com', '1234432112', 'Resume content here'),
(11, 'Jessica', 'White', 'jessicaw@example.com', '2324556678', 'Resume content here'),
(12, 'Brian', 'Thomas', 'briant@example.com', '9898776655', 'Resume content here'),
(13, 'Amanda', 'Harris', 'amandah@example.com', '1239875643', 'Resume content here'),
(14, 'Nathan', 'Clark', 'nathanc@example.com', '9988775544', 'Resume content here'),
(15, 'Sophia', 'Martinez', 'sophiam@example.com', '0099887766', 'Resume content here'),
(16, 'Paul', 'Rodriguez', 'paulr@example.com', '2233445567', 'Resume content here'),
(17, 'Samantha', 'Lewis', 'samanthal@example.com', '3322114455', 'Resume content here'),
(18, 'Oliver', 'Lee', 'oliverl@example.com', '7766554433', 'Resume content here'),
(19, 'Lucas', 'Walker', 'lucasw@example.com', '0099882233', 'Resume content here'),
(20, 'Victoria', 'Hall', 'victoriah@example.com', '9988447766', 'Resume content here');

-- Applications 
INSERT INTO applications (applicationId, jobID, applicantId, applicationtime, coverLetter) VALUES
(1, 1, 1, GETDATE(), 'Cover letter content here'),
(2, 2, 2, GETDATE(), 'Cover letter content here'),
(3, 3, 3, GETDATE(), 'Cover letter content here'),
(4, 4, 4, GETDATE(), 'Cover letter content here'),
(5, 5, 5, GETDATE(), 'Cover letter content here'),
(6, 6, 6, GETDATE(), 'Cover letter content here'),
(7, 7, 7, GETDATE(), 'Cover letter content here'),
(8, 8, 8, GETDATE(), 'Cover letter content here'),
(9, 9, 9, GETDATE(), 'Cover letter content here'),
(10, 10, 10, GETDATE(), 'Cover letter content here'),
(11, 11, 11, GETDATE(), 'Cover letter content here'),
(12, 12, 12, GETDATE(), 'Cover letter content here'),
(13, 13, 13, GETDATE(), 'Cover letter content here'),
(14, 14, 14, GETDATE(), 'Cover letter content here'),
(15, 15, 15, GETDATE(), 'Cover letter content here'),
(16, 16, 16, GETDATE(), 'Cover letter content here'),
(17, 17, 17, GETDATE(), 'Cover letter content here'),
(18, 18, 18, GETDATE(), 'Cover letter content here'),
(19, 19, 19, GETDATE(), 'Cover letter content here'),
(20, 20, 20, GETDATE(), 'Cover letter content here');

INSERT INTO applications (applicationId, jobID, applicantId, applicationtime, coverLetter) VALUES
(21, 1, 1, GETDATE(), 'Cover letter content here'),    
(22, 1, 2, GETDATE(), 'Cover letter content here'),   
(23, 2, 3, GETDATE(), 'Cover letter content here'),    
(24, 3, 1, GETDATE(), 'Cover letter content here'),    
(25, 4, 4, GETDATE(), 'Cover letter content here'),    
(26, 5, 5, GETDATE(), 'Cover letter content here'),    
(27, 6, 6, GETDATE(), 'Cover letter content here'),    
(28, 7, 7, GETDATE(), 'Cover letter content here'),    
(29, 8, 8, GETDATE(), 'Cover letter content here'),    
(30, 9, 9, GETDATE(), 'Cover letter content here');  


--============================================================================================================

--5. Write an SQL query to count the number of applications received for each job listing in the "Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all jobs, even if they have no applications.

select count(jobTitle) as application_count,jobTitle
from jobs
group by jobTitle;


--============================================================================================================

--6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary 
--range. Allow parameters for the minimum and maximum salary values. Display the job title, 
--company name, location, and salary for each matching job.

select j.jobTitle,c.companyId,j.jobLocation,j.salary from jobs as j 
JOIN
companies as c
on j.companyId = c.companyId
where j.salary between 80000 and 100000;


--============================================================================================================


--7. Write an SQL query that retrieves the job application history for a specific applicant. Allow a 
--parameter for the ApplicantID, and return a result set with the job titles, company names, and 
--application dates for all the jobs the applicant has applied to.

select * from applicants;

select j.jobTitle,c.companyName,a.applicationtime as ApplicationDate from applications as a
JOIN jobs as j on a.jobID = j.jobId
JOIN companies as c on j.companyId = c.companyId
where a.applicantId = 2;



--============================================================================================================


--8. Create an SQL query that calculates and displays the average salary offered by all companies for 
--job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero.select c.companyName,avg(j.salary) as avg_salary_offered from jobs as jJOINcompanies as con c.companyId = j.companyIdwhere j.salary > 0group by j.companyId,c.companyName;--============================================================================================================
--Write an SQL query to identify the company that has posted the most job listings. Display the 
--company name along with the count of job listings they have posted. Handle ties if multiple 
--companies have the same maximum count.select c.companyName,avg(salary) as avg_salary_offered, count(j.jobTitle) count from jobs as jJOINcompanies as con c.companyId = j.companyIdgroup by j.companyId,c.companyName;--============================================================================================================

ALTER TABLE applicants
ADD experience INT NOT NULL DEFAULT 0;select * from applicants;UPDATE applicants
SET experience = 3
WHERE applicantId IN (1, 2, 3, 4, 5);

UPDATE applicants
SET experience = 1
WHERE applicantId IN (6, 7, 8, 9, 10); UPDATE applicants
SET experience = 2
WHERE applicantId IN (11, 12, 13, 14, 15);

UPDATE applicants
SET experience = 5
WHERE applicantId IN (16, 17, 18, 19, 20); --11. Retrieve a list of distinct job titles with salaries between $60,000 and $80,000.SELECT DISTINCT jobTitle,salary
FROM jobs 
WHERE salary BETWEEN 60000 AND 80000;--============================================================================================================
--============================================================================================================--Retrieve a list of job applicants along with the companies they have applied to and the positions 
--they have applied forselect a.applicantid, a.first_name, a.last_name, c.companyname, j.jobtitle from applicants as a
join applications as app on a.applicantid = app.applicantid
join jobs as j on app.jobid = j.jobid
join companies as c on j.companyid = c.companyid;

--============================================================================================================

--Find companies that have posted jobs with a salary higher than the average salary of all jobs.

SELECT DISTINCT c.companyId, c.companyName
FROM companies AS c
JOIN jobs AS j ON c.companyId = j.companyId
WHERE j.salary > (SELECT AVG(salary) FROM jobs);

--============================================================================================================--Display a list of applicants with their names and a concatenated string of their city and stateselect * from applicants;ALTER TABLE applicants
ADD city VARCHAR(100),
    state VARCHAR(100);
SELECT a.first_name, a.last_name, CONCAT(a.city, ', ', a.state) AS city_state FROM applicants AS a;--Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'SELECT *FROM jobs
WHERE jobTitle LIKE '%Developer%' OR jobTitle LIKE '%Engineer%';


--Retrieve a list of applicants and the jobs they have applied for, including those who have not 
--applied and jobs without applicants

SELECT a.applicantId,a.first_name,a.last_name,j.jobId,j.jobTitle FROM applicants AS a 
FULL OUTER JOIN applications AS ap ON a.applicantId = ap.applicantId
FULL OUTER JOIN jobs AS j ON ap.jobID = j.jobId;

SELECT a.applicantId,a.first_name,a.last_name,c.companyId,c.companyName,c.location FROM applicants AS a
JOIN applications AS ap ON a.applicantId = ap.applicantId
JOIN jobs AS j ON ap.jobID = j.jobId
JOIN companies AS c ON j.companyId = c.companyId
WHERE c.location = 'london' AND a.experience > 2;



