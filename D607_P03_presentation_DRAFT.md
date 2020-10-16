D607_P03_presentation_DRAFT
What are the most valued data science skills?
========================================================
author: Bar Raisers - Large Group Justified
date: 
autosize: true

-	Bharani Nittala
-	Richard Sughrue
-	LeTicia Cancel
-	George Cruz Deschamps
-	Jack Wright

For more details on authoring R presentations please visit <https://support.rstudio.com/hc/en-us/articles/200486468>.

Misc Notes:
========================================================
Cite *Slide (Letter)* for:
- text inclusion/revision
- code snippet inclusion
- plot image inclusion - do 2 things *give me exact name of image*

>For the plot image inclusion, do the following:
- NameTheReference of your plot image within the brackets
- plot image file name within the parenthesis

![NameTheReference image](sample_proj3_plot.png)

***

Example:
![quanteda image](quanteda_screen_cap.JPG)


SAMPLE Visualization(s) - using exported plots
========================================================

Left Column Header
- text above image
![trythis image](sample_proj3_plot.png)
- text below image

***

Right Column Header
- text above image
![trythis image](sample_proj3_plot.png)
- text below image



(Slide A) Overview 
========================================================

- What are the most valued data science skills?
- CIO Perspective
- Webscraping from Social Media Sources
- Tidying, Transforming, and Storage 
- Exploratory Data Analysis
- Key Themes from Social Media Sources
- Summary / Conclusions

- Future Exploratory Data Analysis Opportunities
- Questions


(Slide B) What are the most valued data science skills?
========================================================

>This project  used an exploratory data analysis approach to obtain
 information available in the public domain from leading social media websites to answer this question.

Websites Scraped:
- [LinkedIn](https://www.linkedin.com/)
- [Twitter](https://twitter.com/)
- [Amazon Jobs](https://www.amazon.jobs/en/)
- [Glassdoor](https://www.glassdoor.com/index.htm)

***
CRISPER
CRoss-Industry Standard Process for Data Mining
![CRISPER image](CRISPdatamining.png)


(Slide C) CIO Magazine - Bob Violino, Contributing Writer & CIO
========================================================

> *Essential skills and traits of elite data scientists are -* 
- Critical thinking
- Coding
- Math
- Machine learning, deep learning, AI
- Communication
- Data architecture
- Risk analysis, process improvement, systems engineering
- Problem solving and good business intuition

Reference:
[Violino, B. (2018, Mar 27). *Essential skills and traits of elite data scientists.* CIO Magazine] (https://www.cio.com/article/3263790/the-essential-skills-and-traits-of-an-expert-data-scientist.html)


(Slide D) Data Extraction through Web Scraping Methods
========================================================

- Sources: LinkedIn, Twitter, Amazon Jobs, Glassdoor
- Searched and scraped datasets for "Data Science"
- R Packages used: tidyvest, rvest, httr, jsonlite [name others]
- GadgetSelector (not sure - maybe LeTicia used??)
- "Inspect Element" feature within browser

>Code snippet:
- Initially scraped all jobs listed within NYC metropolitan area





```r
# base url for all jobs search
base_url<-"https://www.linkedin.com/jobs/search/?geoId=90000070&location=New%20York%20City%20Metropolitan%20Area&start="
max<-30
#scrape linkedin
df_null_linkedIn<-linkedIn_scrape_unique(base_url,max)

df_null_linkedIn%>%
  filter(unique())
```

(Slide E) Tidying, Transforming, and Storage 
========================================================

Methods of Tidying & Transforming -
- R Packages: tidyverse,DBI,quanteda,gtools(smartbind)
- Concepts: gtools, smartbind, binding data frames *when column names do not match*
- [Amazon Web Services Relational Database Service (RDS)]  (https://aws.amazon.com/rds/?did=ft_card&trk=ft_card) using MySQL for data storage


(Slide F) Tidying, Transforming, and Storage - Quanteda 
========================================================

> *[Quanteda] (https://cran.r-project.org/package=quanteda)* 
- Quantitative Analysis of Textual Data
- Takes "text mining" to the next level
- Key Concepts - corpus structure, tokens, stopwords

![quanteda image](quanteda_screen_cap.JPG)


```r
jobs_vector<-as.vector(df_data$description)

job_corpus<-corpus(jobs_vector)

dfmat_data<-dfm(job_corpus,
                remove = stopwords("english"), 
                stem = FALSE, remove_punct = TRUE
)
```


(Slide G) Exploratory Data Analysis Methods
========================================================

- Explain high level tasks performed here - initial observations/impressions

Preview of visualizations:
![LinkedIn-A image](Better delta graph.png)
![trythis image](sample_proj3_plot.png)
***
![Twitter-B image](Data Scrape vs Null Scrape Counts.png)
![trythis image](sample_proj3_plot.png)



(Slide H)  Visualization(s) - Twitter with LinkedIn scrapes
========================================================

LinkedIn
- some text above image
![LinkedIn-A image](Better delta graph.png)
- some text below image
- specific characteristics expressed more often for DS jobs than non-DS
- some more text

***

Twitter
- based on twitter #hashtags
![Twitter-A image](sample_proj3_plot.png)

- some text below image
- other points


(Slide I) Visualization(s) - Twitter
========================================================

- Extraction *snap shot* of most recent 1,000 "DataScience" tweets at time of execution
- Ranked bar graphs of #hashtags embedded within extracted tweets
![Twitter-B image](Data Scrape vs Null Scrape Counts.png)


- Elaborate on key info features of EDA from Twitter


```r
# put excerpts of code sets here -  
```

(Slide J) Visualization(s) - LinkedIn
========================================================

Wordcloud
![LinkedIn-Wordclound image](sample_proj3_plot.png)

- other points

- Elaborate on key info features of EDA from LinkedIn


```r
# put excerpts of code sets here
```


(Slide K) Visualization(s) - Salary ranges GlassDoor
========================================================

![Glassdoor image](sample_proj3_plot.png)

- time frame represented in extraction:
- other points

- Elaborate on key info features of EDA from GlassDoor



```r
# put excerpts of code sets here
```


(Slide L) Visualization(s) - Amazon Jobs in Data Science
========================================================

![AmazonJobs image](sample_proj3_plot.png)

- time frame represented in extraction:
- other points

- Elaborate on key info features of EDA from Amazon Jobs





```r
# put excerpts of code sets here
```


(Slide M) Visualization(s) - R versus Python 
========================================================

According to Anand Rao, global artificial intelligence and innovation lead for data and analytics at consulting firm PwC (Violino, 2018):

> *"language of choice in data science is moving towards Python, with a substantial following for R as well"*

The evidence from the following graph affirms this point.

![RvPython image](sample_proj3_plot.png)



```r
# put excerpts of code sets here
```

(Slide N) Visualization(s) - Data Scientist Internships
========================================================

One observation from data extraction is the number of Data Scientist Internship positions with:
- Spotify
- CVS Health
- others identified in LinkedIn extraction
- Amazon Jobs list ??

![Internships image](sample_proj3_plot.png)


```r
# put excerpts of code sets here
```

(Slide O) Summary/Conclusions
========================================================
So What are the most valued data science skills?

[Pick following from Violino's list affirming points in his 2018 article based on our EDA]
- Critical thinking
- Coding
- Math
- Machine learning, deep learning, AI
- Communication
- Data architecture
- Risk analysis, process improvement, systems engineering
- Problem solving and good business intuition


(Slide P) Future Exploratory Data Analysis Opportunities
========================================================

Enhancing this framework to consider questions such as:
- Increase in working remotely in DS as a result on COVID-19
- Association between level of compensation and years of experience / higher learning
- Influence of MOOC (Massive Open Online Courses) with increasing learning opportunities
- YouTube as learning channels (> 100K DS videos loaded since beginning 2020!)
- Certain industries investing more heavily in DS?




Questions - 
========================================================

