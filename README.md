# DS607-Project3
## DATA SCIENCE SKILLS THAT MATTER

Our group embarked on the quest to find an answer to the title question. Our approach consisted of trying to identify the terms that are commonly tagged along with the Twitter handle #Datascience. This provides the keywords that are most often associated with ‘data science’. The top 20 de-duped keywords will serve as a dictionary for the analysis. It is important to note that, these keywords may not be used in professional job listings. To validate the findings from Twitter, professional job listing sites in the US such as LinkedIn and Indeed will be used. 

### Folder Organization
  
  `
  .
   
    ├── data                                # Supporting data for quick running rmd files
    
    ├── docs                                # Documentation files (alternatively `doc`)
    
    ├── analysis                            # Some of the individual analysis files
    
    ├── functions                           # commonly used functions
    
    ├── images                              # Images used in the reports
    
    ├── R script segments for presentation  # This folder contains several scraper functions and analysis organized for the presentation
    
    └── README.md
`
### Credentials and Secrets
To access the AWS DB, you need to setup a credentials file.  The system looks for this file in a folder *outside* of the project's folder.
This folder is called: `C:\password-files-for-r`
In this folder, set up a csv file called: `AWS_login` with the following values: 

`
login_name,login_password,login_schema,login_host

<login_name>,<login_password>,<login_schema>,<login_host>
`
Replace the second row with the proper values.

Access to the Twitter API follows the same procedure, place a file called: `twitter_api` in the same folder outside of the project's root folder. 

`
key_api, secret_api, token_acces, token_secret

<key_api>, <secret_api>, <token_acces>, <token_secret>
`


### Credits

- Bharani Nittala
- Richard Sughrue
- LeTicia Cancel
- George Cruz Deschamps
- Jack Wright
