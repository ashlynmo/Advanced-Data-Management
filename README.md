# Advanced-Data-Management
This project was completed as part of my coursework for the WGU Bachelors of Science in Software Engineering. It uses the [PostgreSQL Sample Database](https://neon.com/postgresql/postgresql-getting-started/postgresql-sample-database) to create a business report based on DVD rental data. The goal is to generate insights about movie genre popularity to support inventory management and promotional planning for a DVD rental business.  

The project includes:

- Identification of relevant tables and fields in the dataset
- Data transformations using user-defined functions
- Creation of detailed and summary report tables
- SQL queries to extract raw data
- A trigger to keep the summary table updated
- A stored procedure to refresh report tables

### A.  Summarize one real-world written business report that can be created from the DVD Dataset from the “Labs on Demand Assessment Environment and DVD Database” attachment.  

The DVD rental business wants to identify which movie genres are the most popular for the purpose of supporting inventory stocking and promotional efforts. The report will provide detailed and aggregated data on rental activity by genre. 

<br>

**1.  Identify the specific fields that will be included in the detailed table and the summary table of the report.**

#### Detailed Table Fields

| Field                  | Data Type |
|-------------------------|-----------|
| rental.rental_id        | INTEGER   |
| rental.rental_date      | TEXT      |
| film.title              | TEXT      |
| category.name AS genre  | TEXT      |

#### Summary Table Fields

| Field                  | Data Type |
|-------------------------|-----------|
| category.name AS genre  | TEXT      |
| total_rentals           | INTEGER   |

<br>

**2.  Describe the types of data fields used for the report.** 

- INTEGER: rental_id, rental_date, total_rentals 

- TEXT: title, genre 

<br>

**3.  Identify at least two specific tables from the given dataset that will provide the data necessary for the detailed table section and the summary table section of the report.** 

- Rental: This table has data about each rental transaction, including the rental ID and rental date. 

- Film: The film table provides the title of each movie. 

- Film_Category: The film_category table contains the genre names. 

<br>

**4.  Identify at least one field in the detailed table section that will require a custom transformation with a user-defined function and explain why it should be transformed (e.g., you might translate a field with a value of N to No and Y to Yes).** 

The rental date in the detailed table will require a custom transformation. This field stores the date of each rental in the format YYYY-MM-DD, which isn’t very easy to read. A function that converts it to a written format such as “Jun 1st, 2025” will provide better readability. 

<br>

**5.  Explain the different business uses of the detailed table section and the summary table section of the report.**  

The detailed table is useful for analyzing genre performance on a per-film or per-date basis, while the summary table shows how many times each genre was rented. Both of these tables make it easier for the DVD rental store to see which genres are most in demand, so they can make strategic decisions about which types of movies to promote or stock more heavily. 

<br>

**6.  Explain how frequently your report should be refreshed to remain relevant to stakeholders.**
   
The report should be refreshed once a month to remain relevant to stakeholders. Genre-related rental trends won’t change enough to refresh the report daily, so monthly data is enough for inventory and marketing planning. A monthly update would give good insight into performance while lessening the workload on the database. 

### B.  Provide original code for function(s) in text format that perform the transformation(s) you identified in part A4. 

 In proj.sql

### C.  Provide original SQL code in a text format that creates the detailed and summary tables to hold your report table sections. 
 
In proj.sql
 

### D.  Provide an original SQL query in a text format that will extract the raw data needed for the detailed section of your report from the source database. 

 In proj.sql

### E.  Provide original SQL code in a text format that creates a trigger on the detailed table of the report that will continually update the summary table as data is added to the detailed table. 

 In proj.sql

### F.  Provide an original stored procedure in a text format that can be used to refresh the data in both the detailed table and summary table. The procedure should clear the contents of the detailed table and summary table and perform the raw data extraction from part D. 

In proj.sql 

