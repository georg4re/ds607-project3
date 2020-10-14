# login to AWS db

#prompt for input 

password_file<-"C:\\password-files-for-r\\AWS_login.csv"

passwords<-read.csv(password_file)
# read in login credentials
df_login <- passwords   # read in login credentials

vardb_user <- df_login$login_name
vardb_password <- df_login$login_password
vardb_schema <- df_login$login_schema
vardb_host <- df_login$login_host

#cat("Host: ", vardb_host, " Schema=", vardb_schema, " username=", vardb_user, " password=", vardb_password)


mydb = dbConnect(RMySQL::MySQL(), user=vardb_user,  password=vardb_password, port=3306, dbname=vardb_schema, host=vardb_host)




# correct file encoding for upload to MySQL

write.table(ny_scrape,file="tmp.txt", fileEncoding ="utf8")
mydata_utf8 <- read.table(file="tmp.txt",encoding="utf8") 


#upload table to MySQL

written_df<-dbWriteTable(mydb,"nyc_data_scrape",
                         mydata_utf8,append=TRUE,row.names=FALSE)


