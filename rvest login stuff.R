library(rvest) 

#Address of the login webpage
login<-"https://www.linkedin.com/login?fromSignIn=true&trk=guest_homepage-basic_nav-header-signin"

#create a web session with the desired login address
pgsession<-html_session(login)
pgform<-html_form(pgsession)[[1]]  #in this case the submit is the 2nd form
filled_form<-set_values(pgform, session_key="xxxemail_or_login_name", session_password="xxxpasswordxxx")
submit_form(pgsession, filled_form)
