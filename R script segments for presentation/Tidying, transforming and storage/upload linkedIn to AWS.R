# login to AWS db
source("functions/get_db_connection.R")

# connect to AWS DB
# prompt for input 
mydb <- getDbConnection()

# correct file encoding for upload to MySQL
write.table(df_null_linkedIn,file="tmp.txt", fileEncoding ="utf8")
mydata_utf8 <- read.table(file="tmp.txt",encoding="utf8") 


#upload table to MySQL
written_df<-dbWriteTable(mydb,"null_linkedin",
                         mydata_utf8,append=TRUE,row.names=FALSE)

