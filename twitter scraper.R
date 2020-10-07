library(twitteR)
library(tidyverse)
library(ggplot2)
library(tidytext)
library(stringr)


key_api<-"xxx"
secret_api<-"wxxn"
token_acces<-"xxx"
token_secret<-"xxxx"



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


ggplot(count_word_cut, mapping=aes(x=reorder(word,word_count),y=word_count))+
  geom_bar(stat="identity")+
  coord_flip() +
  labs(title="Twitter Scrape for hashtags when #DataScience is Used",x="hashtags", y="count")
