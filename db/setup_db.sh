#!/usr/bin/bash
source config.sh

echo "Creating tables..."
RUN_SQL_FILE "create_tables.sql"
echo "Creating tables done."

echo
echo "Populating tables..."
RUN_SQL_FILE "student_data.sql"
echo "Populating tables done."

count=$(RUN_DB_CMD "SELECT COUNT(*) FROM students;")
echo "Inserted $count rows."
