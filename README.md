Analyzing Students' Mental Health
==================================
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)![Jupyter Notebook](https://img.shields.io/badge/jupyter-%23FA0F00.svg?style=for-the-badge&logo=jupyter&logoColor=white)![Bash Script](https://img.shields.io/badge/bash_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

***Part of a Data Engineer Portfolio: [jrili/data-engineer-portfolio](https://github.com/jrili/data-engineer-portfolio)***

# Project Description
This project delves into the mental health of international students at a Japanese university, focusing on how the length of stay influences mental well-being. Utilizing SQL for data manipulation and analysis, the project examines diagnostic scores related to depression, social connectedness, and acculturative stress.

The dataset used, taken from [A Dataset of Students’ Mental Health and Help-Seeking Behaviors in a Multicultural Environment](https://www.mdpi.com/2306-5729/4/3/124), comprises 268 records providing insights into the challenges faced by students adapting to new cultural environments

# Project Objectives
* Determine how the length of stay affects mental health diagnostic scores among international students
* Analyze the relationship between social connectedness, acculturative stress, and depression levels
* Apply SQL skills to perform exploratory data analysis on real-world datasets.

# Tools & Technologies Used
* Postgres 17.4
* SQL
* Bash
* Jupyter Notebook

# Specifications
Analyze the `students` data to see how the length of stay (`stay`) impacts the average mental health diagnostic scores of the international students present in the study.

The information required are:

| Column Name | Description |
| ----------- | ----------- |
| `stay` | Length of stay in years |
| `count_int` | The number of international students for each length of stay |
| `average_phq` | Average of the total depression scores, measured by PHQ-9 test, found in the `ToDep` column |
| `average_scs` | Average of the total social connectedness scores measured by SCS, found in the `ToSC` column |
| `average_as` | Average of the total Acculturative Stress test scores, found in the `ToAS` (ASISS test) column |

Your task is to compose a query to produce the required information. The table is loaded into a postgreSQL database. 

# Workflow Overview
* Acquire the data from [A Dataset of Students’ Mental Health and Help-Seeking Behaviors in a Multicultural Environment](https://www.mdpi.com/2306-5729/4/3/124) and load it into a Postgres database
* Using SQL, query the data efficiently to calculate the average scores for depression (PHQ-9), social connectedness (SCS), and acculturative stress (ASSIS)
* Compile the analysis results into a summary table to provide a clear overview of the findings

# How to execute script:
## Preqrequisites
> [!NOTE]
> Most of the steps here are tailored for Linux systems, specifically tested for CentOS 9

### 1. Gather the other required data file/s
```
cd data

wget https://mdpi-res.com/d_attachment/data/data-04-00124/article_deploy/data-04-00124-s001.zip

unzip data-04-00124-s001.zip

```

After extraction, there will be three (3) files:
* data.csv 
* Questionnaire1.pdf 
* Questionnaire2.pdf

We will only need the `data.csv` file. Feel free to delete the PDF files and the source ZIP file.

> [!NOTE]
> In case of unavailability, a snapshot of `data.csv` is also available in the data directory.
> Date of snapshot: `2025 Apr 22`

### 2. Setup PostgreSQL database service
> [!NOTE] _Skip if already available_
* Download installer and follow instructions here depending on your OS:
  * For **CentOS 9**: [How to install PostgreSQL on CentOS 9 + create roles and databases](https://www.hostinger.com/tutorials/how-to-install-postgresql-on-centos)
    * For this project, PostgreSQL 13 is used
    * Follow the steps until you areable to connect to the psql shell
  * Others: [PostgreSQL Downloads](https://www.postgresql.org/download/)

### 3. Setup a PostgreSQL role with CREATEROLE and CREATEDB priviliges
> [!NOTE] _Skip if already available_

* Switch to the `postgres` account automatically created upon PostgreSQL installation
    ```
    su postgres
    <Enter password>
    ```
* Open `psql` shell
    ```
    bash-5.1$ psql
	psql (17.4)
	Type "help" for help.
    ```
* Create a Postgres admin user with a password and `CREATEROLE` and `CREATEDB` privileges, e.g.
    ```
    postgres=# CREATE ROLE <username> WITH LOGIN PASSWORD '<password>' CREATEROLE CREATEDB;
	CREATE ROLE
    ```

    e.g.
    ```
    postgres=# CREATE ROLE postgres_admin WITH LOGIN PASSWORD 'postgres_admin_pass' CREATEROLE CREATEDB;
	CREATE ROLE
    ```

### 4. Create a postgreSQL role, database, specifically for this project
* Open `db/config.sh` from this repository
* Modify the following:
    * `DB_HOST`: the host where the DB is running, e.g. `localhost`
    * `DB_PORT`: the port where the DB is listening on, e.g. `5432`
    * `DB_ADMIN_USER`: the Postgres admin username created in the previous step
    * `DB_NAME`: the database name for the project
* Run the `init_db.sh` in the `db` directory
    * Note that the Postgres admin password will be asked multiple times

### 5. Create table and load the data from CSV into a PostgreSQL table
> [!NOTE]
> The sql file for creating the table is already available in this repository in the file `create_tables.sql`<br>
> Note that since there is no unique identifier available in the dataset, a `serial_id` column is added for this project to be used as the primary key.

#### Option 1: From SQL INSERT statements
* Convert CSV into SQL `INSERT` statements using a tool, e.g. https://www.convertcsv.com/csv-to-sql.htm

* Save contents to an SQL file e.g. `student_data.sql`
    > [!NOTE]
    > A copy of the processed `student_data.sql` is also committed in this repository in the `db` directory.

* Run `setup_db.sh` in the `db` directory

#### Option 2: Using built-in `COPY` command in PostgreSQL
* TODO
* Link to guide: [Importing CSV Files to PostgreSQL Databases](https://web.archive.org/web/20101030205652/http://ensode.net/postgresql_csv_import.html)

### 6. Install required libraries
```
python -m pip install -r requirements.txt
```

## Execution Steps
_(Tested in Python 3.13 and Postgres 17.4)_
* Run notebook:  [datacamp_analyzing_students_mental_health.ipynb](https://github.com/jrili/datacamp-analyzing-students-mental-health/blob/master/datacamp_analyzing_students_mental_health.ipynb)

# Key Learning Points
* Gained hands-on experience in writing complex SQL queries for data aggregation and analysise
* Learned about the psychological challenges international students face and the importance of support systems
* Developed skills in interpreting statistical results to draw meaningful conclusions about mental health trends

# Future Improvements
* Add instructions to import CSV data directly to database
* Incorporate visualization tools to graphically represent the relationship between stay duration and mental health scores
* Expand the study to include longitudinal data to observe changes over time

# Acknowledgements
## Source Course
* [Analyzing Students' Mental Health (DataCamp)](https://app.datacamp.com/learn/projects/analyzing_students_mental_health/guided/SQL)
* Course Instructor: [Jasmin Ludolf](https://www.datacamp.com/instructors/jasminludolf)
## Dataset Source
* [A Dataset of Students’ Mental Health and Help-Seeking Behaviors in a Multicultural Environment](https://www.mdpi.com/2306-5729/4/3/124)
* Authors:
    * Minh-Hoang Nguyen
    * Manh-Toan Ho
    * Quynh-Yen T. Nguyen
    * Quynh-Yen T. Nguyen
    * Quan-Hoang Vuong