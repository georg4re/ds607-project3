# Login to AWS
library(DBI)
library(tidyverse)
library(quanteda)
library(gtools)

# Import the DB Connection function
source("functions/get_db_connection.R")

# connect to AWS DB
# prompt for input 
mydb <- getDbConnection()

#load dbs
dbListTables(mydb)

#read the data from the tables
df_data<-dbReadTable(mydb,"nyc_data_scrape")
df_null<-dbReadTable(mydb,"null_linkedin")

#pull out descriptions as vector
jobs_vector<-as.vector(df_data$description)
null_vector<-as.vector(df_null$description)

job_corpus<-corpus(jobs_vector)
null_corpus<-corpus(null_vector)

dfmat_data<-dfm(job_corpus,
                remove = stopwords("english"), 
                stem = FALSE,
                remove_punct = TRUE)

dfmat_null<-dfm(null_corpus,
                remove = stopwords("english"), 
                stem = FALSE, 
                remove_punct = TRUE)

data_sum<-colSums(dfmat_data)
data_words<-colnames(dfmat_data)

df_data<-rbind(data_words,data_sum)

null_sum<-colSums(dfmat_null)

null_words<-colnames(dfmat_null)

df_null<-rbind(null_words,null_sum)

df_dat_null<-smartbind(df_data,df_null, fill=0)

# Filter out the columns we need
df_dat_null<-t(df_dat_null)%>%
  as.data.frame()%>%
  select("1:2","2:2")

column_names<-c("data","null")
test<-t(df_dat_null)

colnames(test)<-c("data","null")

df_long<-as.data.frame(test)
df_long$data<-as.numeric(df_long$data)
df_long$null<-as.numeric(df_long$null)

test<-df_long%>%
  mutate(delta=data-null)

test3<-rownames(df_long)
df_final<-cbind(test3,test$delta)

#set column names
colnames(df_final)<-c("word","delta")


#turn into data frame for graphing
df_final<-as.data.frame(df_final)

#arrange by descending delta
df_final1<-df_final%>%
  arrange(desc(delta))
view(df_final1)


df_final1$delta<-as.integer(df_final1$delta)

view(gg_output)

#arrange by order and 
output_df<-df_final1%>%arrange(desc(delta))
gg_output<-output_df%>%
  filter(delta>60)

#remove "data" and "science" for clarity
gg_output<-gg_output[-c(1,2),]

#plot
ggplot(gg_output, aes(x=reorder(word,delta), delta))+
  geom_bar(stat="identity")+
  coord_flip()+
  labs(title="Largest difference in count between a null scrape and a scrape for 'data science'")+
  ylab("words")+
  xlab("total difference")


