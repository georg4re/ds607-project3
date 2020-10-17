library(DBI)
library(tidyverse)
library(quanteda)

getDbConnection <- function() {
  # This function returns a DB Connection to AWS
  password_file<-"C:\\password-files-for-r\\AWS_login.csv"
  
  # read in login credentials
  df_login<-read.csv(password_file)
  
  # Uncomment this next line to see the values 
  # cat("Host: ", vardb_host, " Schema=", vardb_schema, " username=", vardb_user, " password=", vardb_password)
  mydb = dbConnect(RMySQL::MySQL(), 
                   user=df_login$login_name, 
                   password=df_login$login_password, 
                   port=3306, 
                   dbname=df_login$login_schema, 
                   host=df_login$login_host)
  
  return(mydb)
}