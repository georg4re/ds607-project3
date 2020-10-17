# quanteda analysis
library(tidyverse)
library(quanteda)

#load in jobs list
description_vector<-jobs_vector

#turn into "corpus" type data frame
job_corpus<-corpus(description_vector)

#you can add in names and other vectors you want to analyze here, i havent yet
summary(job_corpus, n=5)

#tidy job_corpus by removing stop words and punctuation
dfmat_data<-dfm(job_corpus,
                  remove = stopwords("english"), 
                  stem = FALSE, remove_punct = TRUE)

#analyze
#twitter analyzing
#load scraped twitter data
count_word_cut<-count_word%>%
  filter(word_count>20)

#plot twitte words
ggplot(count_word_cut, mapping=aes(x=reorder(word,word_count),y=word_count))+
  geom_bar(stat="identity")+
  coord_flip() +
  labs(title="Twitter Scrape for hashtags when #DataScience is Used",x="hashtags", y="count")

#look at the occurence of the words from our twitter dictionary
#creating a dictionary MANUALLY, maybe there is a way to do it 
#programatticaly
twitter_dict<-dictionary(list(AI=c("AI", "artificial intelligence"),machine_learning=c("machine learning","ml"),iot=c("internet of things","iot"),big_data=c("big data"),python=c("python"),analytics=c("data analytics"),digital_transformation=c("digital transformation"),R=c(" R ","-R"),java=c("javascript","java"),RStats=c("Rstats")))

#search job corpus for dictionary words
dfmat_data_dict<-dfm(job_corpus, dictionary=twitter_dict)
topfeatures(dfmat_data_dict)

#looks bad, wordcloud doesnt work on the amazon stuff because more 
#extraction of unecessary symbols dont get pulled out
textplot_wordcloud(dfmat_data_dict, min_count = 1, random_order = FALSE, rotation=.25, color=RColorBrewer::brewer.pal(8,"Dark2"))

#NEED A VISUALIZATION OF THE DIFFERENCE BETWEEN TWITTER AND JOB SCRAPE

