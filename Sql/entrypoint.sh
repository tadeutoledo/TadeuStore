
#!/bin/bash
wait_time=20s
password="Password!@#"

# wait for SQL Server to come up
echo importing data will start in $wait_time...
sleep $wait_time
echo executing script...

# run the init script to create the DB and the tables in /table
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P $password -i ./Sql/init-db.sql

echo executing ScriptSchema...

/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P $password -i ./Sql/ScriptSchema.sql

echo end ...