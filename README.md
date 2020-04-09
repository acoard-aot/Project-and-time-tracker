# time-machine
Time and billing management tool

# Run the TimeMachine application locally 
Step 1: Provide all the environment variables in .env file

Step 2: Verify and update keycloak.json in 'web/public/statics'

Step 3: docker-compose build

Step 4: docker-compose up

Step 5: http://localhost:8080

# Set up Database

**note: if you prefer to use Docker, see below**

Step 1: Create a postgres database (To run application in docker, make sure the database is in a public ip or cloud).

Step 2: Provide the database details in .env file

Step 3: Once you run the application all the schema will be created.

Step 4: Execute *BC_Timesheet_MasterData.sql* to create all master data required by default.

## Using Docker for Postgress

Make sure you have docker and docker-compose installed (`docker-compose --version`)

```bash
    # Download + run Postgress
    docker-compose -f dev-docker-compose.yaml up -d

    # get "Name" or "Contaienr ID" of Postgress
    docker ps

    # ssh in - replace {container} with name from above, or if yours is the same as mine copy the name
    docker exec -it {container} bash
    docker exec -it projectandtimetracker_db_1 bash

    # Login to postgress process
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB"
    
    # import sql - tip: use tab completion
    \i BC_Timesheet_MasterData.sql
    # \i Risk_MasterData.sql  - Replaced with 'latest' below.
    \i Risk_MasterData_Latest.sql

    # log out of container
    exit
```

  docker run --name timemachine-nginx -v /home/arc/prod/app:/app:ro -v /home/arc/prod/nginx.conf:/etc/nginx/nginx.conf:ro -d -p 80:80 nginx

  docker container start timemachine-nginx

Addenda
March 4, 2019

Question: The opportunity lists the following as the milestone for payment. My concern with this approach is that our team will be forced to almost work in waterfall model and not agile. We would be focussed on achieving these phases and not necessarily the agile manifesto where we can make decisions based on your priority.

Answer: The intent of this procurement is the development of a pilot project for the intake form, time tracker, project tracker and dashboard. The critical need here is to demonstrate to senior leadership the opportunity in these pilots so that continuous development will be considered where we can develop these tools further in an Agile framework.





