#packages

library(twitteR)
library(tidyverse)

#local file with your twitter devs password .csv
#password_file<-"C:\\password-files-for-r\\twitter_passwords.csv"

twitter_login<-function(password_file){
  
  twitter_passwords<-read.csv(password_file)
  
  #input passwords
  key_api<-twitter_passwords$key_api
  secret_api<-twitter_passwords$secret_api
  token_acces<-twitter_passwords$token_access
  token_secret<-twitter_passwords$token_secret
  
  #login
  setup_twitter_oauth(key_api,secret_api,token_acces,token_secret)
  
}


#test twitter login
#twitter_login(password_file)

co_hashtag_scraper<-function(hashtag_target,n_tweets){
  
  tweets_ds<-searchTwitter(hashtag_target,n_tweets)
  
  #transform tweets list into a data frame
  tweets.df4<-twListToDF(tweets_ds)
  just_text<-tweets.df4$text%>%unlist()
  
  #extract hashtags
  pattern<-'(?<=#)[A-z]+'
  just_hash<-str_extract_all(just_text,pattern)
  just_hash_unlist<-just_hash%>%unlist()
  #put in data frame
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
  
  return(count_word)
}


#co_hashtag_scraper() takes in a hashtag and the number of tweets
#you want to scrape, outputs unique hashtags used in conjunction
#with the input hashtag as a data frame

#co_hashtag_scraper test
#function_output<-co_hashtag_scraper("#DataScience",1000)
