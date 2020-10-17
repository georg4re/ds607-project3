library(twitteR)
library(tidyverse)
library(ggplot2)
library(tidytext)
library(stringr)

#Access to security file
password_file<-"C:\\password-files-for-r\\twitter_api.csv"

passwords<-read.csv(password_file)
# read in login credentials
setup_twitter_oauth(passwords$key_api,
                    passwords$secret_api,
                    passwords$token_acces,
                    passwords$token_secret)

#search hashtag
tweets_ds<-searchTwitter('#DataScience',n=1000)

#transform tweets list into a data frame
tweets.df4<-twListToDF(tweets_ds)

just_text<-tweets.df4$text%>%unlist()

pattern<-'(?<=#)[A-z]+'

just_hash<-str_extract_all(just_text,pattern)

just_hash_unlist<-just_hash%>%unlist()

#extract single words from hashtag
word.df<-data.frame("word"=just_hash_unlist)

#group repeated words and count them
unique_word<-word.df%>%
  group_by(word)%>%
  summarize(word_count=n_distinct(word))%>%
  arrange(word_count)

count_word<-word.df%>%
  filter(word!="DataScience")%>%
  group_by(word)%>%
  summarize(word_count=sum(!is.na(word)))%>%
  arrange(desc(word_count))

#Filter only words that are mentioned more than 20 times
count_word_cut<-count_word%>%
  filter(word_count>20)

#ggplot
ggplot(count_word_cut, mapping=aes(x=reorder(word,word_count),y=word_count))+
  geom_bar(stat="identity")+
  coord_flip() +
  labs(title="Twitter Scrape for hashtags when #DataScience is Used",x="hashtags", y="count")

