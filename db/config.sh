DB_HOST=localhost
DB_PORT=5432
DB_NAME=localprojects
DB_ADMIN_USER=postgres_admin

DB_TABLE_NAME=students
DB_PROJ_USER=postgres_proj_user
DB_PROJ_PASS=postgres_proj_pass

function RUN_DB_ADMIN_CMD() {
	db="postgres"
	if [ -n "$2" ]; then
		db=$2
	fi
	psql -h $DB_HOST -p $DB_PORT -U $DB_ADMIN_USER -W $db -tAc "$1"
	return $?
}

function RUN_DB_CMD() {
	PGPASSWORD=$DB_PROJ_PASS psql -h $DB_HOST -p $DB_PORT -U $DB_PROJ_USER -d $DB_NAME -tAc "$1"
	return $?

}

function RUN_SQL_FILE() {
	PGPASSWORD=$DB_PROJ_PASS psql -h $DB_HOST -p $DB_PORT -U $DB_PROJ_USER -d $DB_NAME -f "$1"
	return $?

}

