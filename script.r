#################################################################
############# Introduction to Data Analysis in R ################
#################################################################

###################
#### About R ######
###################

# R is a programming language that is especially helpful for data programming, used by data journalists and data scientists around the world. The huge community of users is generally friendly, willing to help beginners and great about creating learning materials.
# Learn more: https://www.r-project.org/
# Download R: https://cran.r-project.org/bin/macosx/

###################
## About RStudio ##
###################

# RStudio is an integrated development environment -- similar to MySQL Workbench -- that is designed to help you do data analysis. 
# Learn more: https://www.rstudio.com/products/RStudio/
# Download RStudio: https://www.rstudio.com/products/rstudio/download/#download
# Cheatsheet: https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf

####################
# About R Packages #
####################

# R packages are pre-written bundles of code that provide shortcuts to help you do all kind of different and specific things in the data programming universe -- visualize data, clean data, pull data from Twitter, scrape websites, and a whole lot more. There are THOUSANDS of free packages available for your use.
# All packages: https://cran.r-project.org/
# Some greatest hits: https://awesome-r.com/

#######################
# About The Tidyverse #
#######################

# One particularly useful collection of packages is called The Tidyverse, a collection of related packages that make doing data cleaning, data wrangling, data analysis and data visualization easier. This tutorial makes use of several Tidyverse packages to load, wrangle and analyze data. You can do everything we're doing with the base R language, but it's more of a slog.  My recommendation: if you're using R, use Tidyverse methods instead of base R whenever possible.   
# Site: https://www.tidyverse.org/
# Cheatsheets: https://www.rstudio.com/resources/cheatsheets/
# List of Tidvyerse packages: https://www.tidyverse.org/packages/
# Canonical Book: https://r4ds.had.co.nz/index.html
# Tutorials: https://rstudio.cloud/learn/primers/
# Online Courses: I used to recommend DataCamp, but I can no longer do so.  Looking for good replacements now. 


##########################
## Create an R Project ###
##########################

# It's a good idea to create a new "R Project" file (.Rproj) for each analysis project. Among other things, doing so gives you a folder to store everything in -- data and script files -- and it sets your "working directory" to make it easy to load data.      

# To create a new R Project: Go to Top Menu > File > New File > New Project to create. 

##########################
## Create a Script File ##
##########################

# You can execute R code directly in the console.  But it's a MUCH better idea to write out your scripts in a file (in R, script files end in .r) like this one, and execute them so they run in the console.       

# To create a new script file: Menu > File > New File > R Script.  Name it script.r.  

##########################
#### Install Packages ####
##########################

# The first time you are setting up a new machine, you'll need to install a package.  Once it's on the machine, you don't have to load it again.

# The code below will install all of the packages of the tidyverse. Highlight it and hit the "Run" button above. Notice it executes in the console below.    

install.packages('tidyverse')

##########################
##### Load Packages ######
##########################

# At the start of every session, you must load the packages you want to work with.

library(tidyverse)

##########################
##### Read in Data #######
##########################

# To read in data, we're using a function from the Tidyverse package called readr.
# For more advanced tips information, see:  https://github.com/rstudio/cheatsheets/raw/master/data-import.pdf

# The code below reads in a csv of campaign contributions in the 2018 Maryland governor's race and stores it as an object called md_election. For full documentation, visit: https://github.com/smussenden/data-journalism-19-spring/blob/master/sessions/14/14-In-Class-Lab/14-SQL-Lab-4.md

md_election <- read_csv("md_election.csv")

# Look at the "environment" window at the right.  It shows an object called md_election with 55327 rows (in R, rows are called obs. or observations) and 13 columns (in R, called variables). 

# Look at the console below.  It notes the columns it read in and what encoding it assigned.  It also noted warnings for problems loading in the data.    

##########################
##### Examine Data #######
##########################

# As we go through this section, where applicable I will display the equivalent SQL code. 

# This functions displays the data as a sortable spreadsheet. 

View(md_election)

# SQL Equivalent # 
# SELECT *
# FROM md_election;


##########################
## Get a Sense of Data ###
##########################

# These two functions will give you a sense of what columns are in the data, the column data type and values. They output in the console.

summary(md_election)

glimpse(md_election)

View(head(md_election))

##############################
# Transform and Analyze Data #
##############################

# The tidyverse provides excellent methods for transforming and analyzing data.
# Cheatsheet: # https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf

##############################
##### Selecting Columns ######
##############################

##### Select only certain columns #####  
# Note that we're saving this as a new object called md_election_working.  It pops up as a new object at right.
# The first "argument" of the select function is the name of the spreadsheet -- or dataframe in R parlance -- md_election. This is common with tidyverse functions.  The other three are columns.   

md_election_working <- select(md_election, receiving_committee, contributor_name, contribution_amount)

View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election;

##### Select everything except certain columns ##### 

md_election_working <- select(md_election, -receiving_committee)
View(md_election_working)

##############################
### Introduction to Pipes ####
##############################

# Pipes (%>%) are a big part of the tidyverse, and provide a better way to write functions. 
# Think of them as standing in for the words, "and then".
# Using them lets us store the name of the dataframe at the top of the function, so we don't have to write it again.  This is especially useful when we start chaining commands together. 
# This says "take the dataframe called md_election AND THEN select every column except receiving_committee. 
# Notice that we don't need to put the name of the dataframe as the first argument in the select function.

md_election_working <- md_election %>%
  select(-receiving_committee)
View(md_election_working)

##############################
######### Sorting ############
##############################

##### Sort a column from lowest to highest value #####
md_election_working <- md_election %>%
  arrange(contribution_amount)
View(md_election_working)

# SQL Equivalent # 
# SELECT *
# FROM md_election
# ORDER BY contribution_amount;

##### Sort a column from highest to lowest value #####
md_election_working <- md_election %>%
  arrange(desc(contribution_amount))
View(md_election_working)

# SQL Equivalent # 
# SELECT *
# FROM md_election
# ORDER BY contribution_amount desc;

##############################
##### Chaining with Pipes ####
##############################

# Just like with SQL, we can chain different types of functions together using %>%

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election
# ORDER BY contribution_amount desc;


##############################
######### Filtering ##########
##############################

##### Filtering by one value as an exact match #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(receiving_committee == "Hogan Larry for Governor")
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election
# WHERE receiving_committee = "Hogan Larry for Governor"
# ORDER BY contribution_amount desc;

##### Filtering by one number #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(contribution_amount > 10000)
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election
# WHERE contribution_amount > 10000
# ORDER BY contribution_amount desc;

##### Filtering by two values (AND) #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(contribution_amount > 10000, receiving_committee == "Hogan Larry for Governor")
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election
# WHERE contribution_amount > 10000 AND receiving_committee = "Hogan Larry for Governor"
# ORDER BY contribution_amount desc;

##### Filtering by one value OR another #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(state == "VA" | state == "MD")
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, state, contribution_amount
# FROM md_election
# WHERE state == "VA" OR state == "MD"
# ORDER BY contribution_amount desc;

##### Filtering with wildcards - text in any part of field #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(str_detect(contributor_name, "Republican"))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, state, contribution_amount
# FROM md_election
# WHERE contributor_name LIKE "%Republican%"
# ORDER BY contribution_amount desc;

##### Filtering with wildcards - text at start of field #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(str_detect(contributor_name, "^Republican"))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, state, contribution_amount
# FROM md_election
# WHERE contributor_name LIKE "Republican%"
# ORDER BY contribution_amount desc;

##### Filtering with wildcards - text at end of field #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(str_detect(contributor_name, "Maryland$"))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election
# WHERE contributor_name LIKE "%Maryland"
# ORDER BY contribution_amount desc;

##### Filtering with dates #####

# To make it easier to work with dates, we need to install a new package, lubridate, which has a lot of built in functions to work with dates. 
# Lubridate is a package that is part of the tidyverse family, but it doesn't automatically load when we load the rest of the tidyverse. So we have to load it separately.  We only need to install it once. 

install.packages('lubridate')

# Now load it.  Typically, we'd put this at the top of our script file when we load the rest of the packages.

library('lubridate')

##### Filter based on specific date ##### 

md_election_working <- md_election %>%
  select(receiving_committee, contribution_date, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(contribution_date > as_date("2017-12-31"))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contribution_date, contributor_name, contribution_amount
# FROM md_election
# WHERE contribution_date > "2017-12-31"
# ORDER BY contribution_amount desc;

##### Filter based on year ##### 

md_election_working <- md_election %>%
  select(receiving_committee, contribution_date, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(year(contribution_date) == 2017)
View(md_election_working) 

# SQL Equivalent # 
# SELECT receiving_committee, contribution_date, contributor_name, contribution_amount
# FROM md_election
# WHERE YEAR(contribution_date) = 2017
# ORDER BY contribution_amount desc;

##############################
##### Adding New Columns #####
##############################

#### Add a column with a unique identifier ####
md_election_working <- md_election %>%
  mutate(record_number = row_number())
View(md_election_working) 

#### Add a new column based on another column ####
md_election_working <- md_election %>%
  mutate(contribution_year = year(contribution_date))
View(md_election_working) 

# SQL Equivalent # 
# SELECT *, YEAR(contribution_date) as contribution_year
# FROM md_election;

#### Add several new columns based on another column ####

md_election_working <- md_election %>%
  mutate(contribution_year = year(contribution_date),
         contribution_month = month(contribution_date))
View(md_election_working) 

# SQL Equivalent # 
# SELECT *, YEAR(contribution_date) as contribution_year, MONTH(contribution_date) as month
# FROM md_election;

#### Using If Else to create new columns ####

md_election_working <- md_election %>%
  mutate(contribution_size = if_else(contribution_amount > 10000, "large_contribution", "small_contribution"))

# SQL Equivalent # 
# SELECT *, contribution_amount, IF(contribution_amount > 10000, "large contribution", "small contribution") as contribution_size
# FROM md_election;

#### Create new columns with a different version of nested If Else statements ####

md_election_working <- md_election %>%
  mutate(contribution_size = case_when(
    contribution_amount > 20000 ~ "very large",
    contribution_amount > 10000 ~ "large",
    contribution_amount > 1000 ~ "medium",
    contribution_amount > 0 ~ "small"))           
View(md_election_working)           
   
#### Create new columns based on math ####

md_election_working <- md_election %>%
  mutate(contribution_times_10 = contribution_amount*10)
View(md_election_working)

# SQL Equivalent # 
# SELECT *, (contribution_amount*10) as contribution_times_10
# FROM md_election;


##############################
# Calculating Summary Stats ##
##############################

#### Grouping by a column and counting ####
md_election_working <- md_election %>%
  group_by(receiving_committee) %>%
  summarise(number_records = n()) %>%
  arrange(desc(number_records))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, count(*) as number_records
# FROM md_election
# GROUP BY receiving_committee
# ORDER BY number_records desc;

#### Grouping by two columns and counting ####

md_election_working <- md_election %>%
  group_by(receiving_committee, state) %>%
  summarise(number_records = n()) %>%
  arrange(receiving_committee, desc(number_records))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, state, count(*) as number_records
# FROM md_election
# GROUP BY receiving_committee, state
# ORDER BY receiving_committee, number_records desc;


#### Creating a summary table with sum, mean, median, min and max ####
md_election_working <- md_election %>%
  group_by(receiving_committee) %>%
  summarise(number_records = n(),
            contribution_total = sum(contribution_amount),
            average_contribution = mean(contribution_amount),
            median_contribution = median(contribution_amount),
            minimum_contribution = min(contribution_amount),
            maximum_contribution = max(contribution_amount)
            ) %>%
  arrange(receiving_committee, desc(number_records))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, count(*) as number_records, SUM(contribution_amount) as contribution_total, AVG(contribution_amount) as average_contribution, min(contribution_amount) as minimum_contribution, max(contribution_amount) as maximum_contribution
# FROM md_election
# GROUP BY receiving_committee
# ORDER BY receiving_committee, number_records desc;

