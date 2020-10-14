#Linkedin Scrape
#dont write new code in this script. select all (ctrl+A) and run 

#write your code in a different form 


library(rvest)
library(tidyverse)


#base of the link we want to build
link_base_url<-"https://www.linkedin.com/jobs/search/?geoId=90000070&keywords=data%20science&location=New%20York%20City%20Metropolitan%20Area&start="
#nmax is the maximum number of pages we want to make
#nmax<-975/25


#function to build db of page links
iterate_pages<-function(link_base_url,max){
  df_link<-data.frame("link"=character())
  link_base_url<-link_base_url
  max<-max
  
  #loop to create links
  for(i in 1:max){
    n<-(i-1)
    page<-as.character(n*25)
    link<-paste0(link_base_url,page)
    df_link<-rbind(df_link, link)
    list_of_links<-pull(df_link,1)
  }
return(list_of_links)
}

#testing iterate_pages()
#link_list<-iterate_pages(link_base_url,nmax)

#pull all job links from a single page
job_links<-function(job_links_list){
  job_links_list<-job_links_list
  jobURL<-list()
  for (i in 1:length(job_links_list)){
    html<-read_html(job_links_list[i])
    temp_urls<-html%>%
      html_nodes(".result-card__full-card-link") %>%
      html_attr("href") %>%
      as.character()
    jobURL<-append(jobURL,temp_urls)
    
  }
  
  
  return(jobURL)
}
#testing job_links()
#job_postings<-job_links(df_link[1,1])


#combine iterate pages and pull links from every page into one function
#added a check to avoid double counting the same link twice. 
all_links_unique_check<-function(link_base_url,max){
  
  link_base_url<-base_url
  max<-max
  link_list<-iterate_pages(link_base_url,max)
  job_link_list<-list()
  for (i in 1:length(link_list)){
    temp_list<-job_links(link_list[i])
    #checks each element from each page by detecting 
    #if the same job title+id is already on our output
    for(n in 1:length(temp_list)){
      
      id<-str_extract(temp_list[n],"(?<=https://www.linkedin.com/jobs/view/)(.)+\\?")
      link_unique<-str_detect(job_link_list,id)
      bool<-sum(link_unique)
      
      
      
      if(bool==0){
        job_link_list<-append(job_link_list,temp_list[n])
      }
    }
  }
  return(job_link_list)
}

all_links<-function(link_base_url,max){
  
  link_base_url<-base_url
  max<-max
  link_list<-iterate_pages(link_base_url,max)
  job_link_list<-list()
  for (i in 1:length(link_list)){
    temp_list<-job_links(link_list[i])
    #checks each element from each page by detecting 
    #if the same job title+id is already on our output
    
        job_link_list<-append(job_link_list,temp_list)
      
    
  }
  job_link_list<-job_link_list%>%
    unlist()
  return(job_link_list)
}
  
#testing all_links()
#test<-all_links(link_base_url,nmax)


#function for pulling single job info

job_scrape<-function(link_to_job_page){
  
  #turn list element into a character
  char_link<-as.character(link_to_job_page)
  #read html into R
  url<-read_html(char_link)
  #pull job title
  jobTitle <- url %>%
    html_nodes(".topcard__title") %>%
    html_text()
  
  #pull company
  company <- url %>%
    html_nodes(".topcard__flavor--black-link") %>%
    html_text()
  
  #pull location
  location <- url %>%
    html_nodes(".topcard__flavor.topcard__flavor--bullet") %>%
    html_text()
  
  #pull number of applicants
  applicants <- url %>%
    html_nodes(".num-applicants__caption") %>%
    html_text()
  #pull salary
  salary <- url %>%
    html_node(".topcard__flavor--salary") %>%
    html_text()
  
  #pull description
  description <- url %>%
    html_nodes(".description__text") %>%
    html_text()
  
  job_vector<-c(jobTitle,company,location,applicants,salary,description,char_link)
  
  return(job_vector)
  
}


#testing job_scrape
#test_vector<-job_scrape(test[2])


#function for applying job scrape to all jobs in a list and building a data.frame

all_jobs_scrape<-function(job_link_list){
  urls<-job_link_list
  #create data frame to load info into
  df_jobs<-data.frame("job_title"=character(),"company"=character(),"location"=character(),"applicants"=numeric(),"salary"=character(),"description"=character(),"href"=character())
  for(i in 1:length(urls)){
    #fill temporary vector with job info
    temp_job<-job_scrape(urls[i])
    #append row to output data frame
    df_jobs<-rbind(df_jobs,temp_job)
  }
  #return data frame with jobs in it
  colnames(df_jobs)<-c("job_title","company","location","applicants","salary","description","link")
  return(df_jobs)
}

#test of all_jobs_scrape (not working when I scrape too much)
#test_jobs_data_frame<-all_jobs_scrape(test[1:100])

#all in one function, full scrape from base url, returns data frame
#link_base_url is the base url without the appened page number thing
#max is the maximum number of pages you want to scrape
linkedIn_scrape<-function(link_base_url,max){
  link_base_url<-link_base_url
  max<-max
  job_link_list<-all_links(link_base_url=link_base_url,max=max)
  final_output_df<-all_jobs_scrape(job_link_list)
  return(final_output_df)
  
  
}


#test for full linkedIn scraper function
#df_linkedin<-linkedIn_scrape(link_base_url,30)


