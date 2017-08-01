#!/bin/bash

logit() {
	echo "$host" > database-inspector.log
}

host="$1"
database="$2"

logit "===================="
logit "STARTING $host $database!"

logit "===================="
logit "TABLE LIST:"
tables=$(mysql -u <snipped user> -p<snipped pw> -h "$host" -D "$database" -e "show tables")
logit "$tables"

logit "===================="
logit "TABLE DESCRIPTIONS:"
for table in $tables
do
	logit "=========="
	logit "TABLE = $table"
	description=$(mysql -u <snipped user> -p<snipped pw> -h "$host" -D "$database" -e "describe $table")
	logit "$description"
	contents=$(mysql -u <snipped user> -p<snipped pw> -h "$host" -D "$database" -e "SELECT * FROM $table LIMIT 10")
	for row in $contents
	do
		if [[ $row != "Tables_in_"* ]]
		then
			logit "$row"
		fi
	done
done


