# linkedin scrape for null jobs set


#Address of the login webpage
login<-"https://www.linkedin.com/login?fromSignIn=true&trk=guest_homepage-basic_nav-header-signin"

#create a web session with the desired login address
pgsession<-html_session(login)
pgform<-html_form(pgsession)[[1]]  #in this case the submit is the 2nd form
filled_form<-set_values(pgform, session_key="jwrightzz1234@gmail.com", session_password="Jack446550")
submit_form(pgsession, filled_form)

# base url for all jobs search
base_url<-"https://www.linkedin.com/jobs/search/?geoId=90000070&location=New%20York%20City%20Metropolitan%20Area&start="
max<-30
#scrape linkedin
df_null_linkedIn<-linkedIn_scrape_unique(base_url,max)

df_null_linkedIn%>%
  filter(unique())


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

write.table(df_null_linkedIn,file="tmp.txt", fileEncoding ="utf8")
mydata_utf8 <- read.table(file="tmp.txt",encoding="utf8") 


#upload table to MySQL

written_df<-dbWriteTable(mydb,"null_linkedin",
                         mydata_utf8,append=TRUE,row.names=FALSE)



