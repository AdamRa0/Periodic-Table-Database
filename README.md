# Periodic-Table-Database
Bash program to get information about some elements.

## Running the project locally.
- Clone the project
- Read the database and its content by running the following command.
```bash
psql -U postgres < periodic_table.sql
```
- Change the username in the PSQL variable to your username.
- Make element.sh to be an executable file by running the following command.
```bash
chmod +x element.sh
```
- Run the project by executing the following command
```bash
./element.sh <element_symbol> or <element_name> or <element atomic number>
```

## Acknowledgements
This project is part of FreeCodeCamp's relational database cirriculum required projects.