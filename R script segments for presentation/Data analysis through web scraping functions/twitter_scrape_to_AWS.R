library(twitteR)
library(tidyverse)
library(ggplot2)
library(tidytext)
library(stringr)
library(DBI)
library(lubridate)


# connect to AWS DB

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


#put my password csv on a private github 
#so i can get it from any computer
location<-"C:\\password-files-for-r\\twitter_passwords.csv"
twitter_passwords<-read.csv(location)


#input passwords
key_api<-twitter_passwords$key_api
secret_api<-twitter_passwords$secret_api
token_acces<-twitter_passwords$token_access
token_secret<-twitter_passwords$token_secret


#login with function from twitteR  
setup_twitter_oauth(key_api,secret_api,token_acces,token_secret)



#Test search
tweets_ds<-searchTwitter('#DataScience',n=1000)


#transform tweets list into a data frame
tweets.df4<-twListToDF(tweets_ds)

just_text<-tweets.df4$text%>%unlist()

pattern<-'(?<=#)[A-z]+'

just_hash<-str_extract_all(just_text,pattern)

just_hash_unlist<-just_hash%>%unlist()

word.df<-data.frame("word"=just_hash_unlist)


unique_word<-word.df%>%
  group_by(word)%>%
  summarize(word_count=n_distinct(word))%>%
  arrange(word_count)


count_word<-word.df%>%
  filter(word!="DataScience")%>%
  group_by(word)%>%
  summarize(word_count=sum(!is.na(word)))%>%
  arrange(desc(word_count))

count_word_cut<-count_word%>%
  filter(word_count>20)
view(count_word_cut)

ggplot(count_word_cut, mapping=aes(x=reorder(word,word_count),y=word_count))+
  geom_bar(stat="identity")+
  coord_flip() +
  labs(title="Twitter Scrape for hashtags when #DataScience is Used",x="hashtags", y="count")





dbGetQuery(mydb, "CREATE TABLE `scrape_two` (
  `word` varchar(20) NOT NULL,
  `word_count` int NOT NULL,
  PRIMARY KEY (`word`)
)")

written_df <- dbWriteTable(mydb, "scrape_two", count_word_cut, append=TRUE, row.names=FALSE)

(loaded_aws_df <- dbGetQuery(mydb, "select * from scrape_two"))


# Disconnect from AWS DB
(dbDisconnect(mydb))