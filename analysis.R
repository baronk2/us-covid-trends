# rpractice / ps-1
#
# A3: Assignment 3
#    Prompts for Assignment 3
#    dhendry@uw.edu
#    Autumn 2022

# Set-up info ---- 
practice.begin("A3", learner="Kevin Baron", email="baronk2@uw.edu")

# Your 37 prompts ----

#                                         Note 01.
# Assignment Overview ----
# 
# *Acknowledgement:* Thanks to Mike Freeman and Kyle Thayer for initially developing
# this assignment. Also, thanks to Abdiwahid Hajir, who provided assistance
# with the Winter 2022 version. Any errors with this version are, of course, my
# responsibility. David Hendry.
#
#
# 1.0 Background ----
#
#       |       xxx
#       |      x 
#       |     x
#  f(t) |       
#       |    x
#       |xxxx      
#       -----------------
#        123456789 ... N 
#             Time ---> 
#
# This figure shows a sketch of a "cumulative sum" time series. 
#
# A time series means data is collected sequentially, usually at regular
# time intervals; for example, every 15 minutes, every 24 hours, or 
# some other appropriate unit of time. A "cumulative sum" means that
# at each point something changes and that the time series is the sum
# of all previous changes. 
#
# Each "x" in the figure represents a data point in a time series, 
# with 1 being the earliest recording and N being the most recent. 
# The y-axis, represents the cumulative sum of things being counted. 
# Sometimes there are large changes, sometimes there are no changes. 
#
# When data is structured this way, the counts strictly increase. 
# In other words, this relationship is, in theory, always true:
#     f(t+1) >= f(t)
#
# In practice, there might be occasions when f(t+1) < f(t); for 
# example, when data collection errors are corrected. Such 
# declines, however, would indicate a problem of some kind - and,
# ideally, one would want to update all necessary data points 
# so that declines are never present.
#
# In a cumulative sum time series, the most recent point is also 
# the total count (objects made, tasks completed, events that 
# have occurred, etc.).
#
## 2.0 Introduction ----
# In this assignment you will work with data related to the COVID-19 
# pandemic. Specifically, you will work three data files, each one 
# is a cumulative sum time series. The time interval is 
# one day (24 hours) and two things are being recorded during
# each daily interval: 
#
#     Variable     Description 
#     --------     -----------
#     cases        The number of COVID infections 
#     deaths       The number of deaths due to COVID
#
# Further, the case and death counts are collected at three different 
# geographic levels of granularity: 
#     national    The U.S. nation as a whole. 
#     state       U.S. states (50 official U.S. States, plus District
#                 of Columbia, plus other territories).
#     county      Each state is divided into counties. There are around 3,000 
#                 counties in the U.S., and, incidentally, Washington State has 
#                 39 counties.*
#
#                 *See County, United States (2022, January 25). In Wikipedia. 
#                          https://en.wikipedia.org/wiki/County_(United_States)
#
# These geographic levels differ, of course, in granularity. A state is made
# up of counties and the nation as a whole is made of states. Thus, in theory
# the county data should add up to the state data and, in turn, the state data
# should add up to the national data.
#
# The data for this assignment comes from the New York Times:  
#     The New York Times. (2022). Coronavirus (Covid-19) Data in the 
#          United States. Retrieved [August 25, 2022], 
#          from https://github.com/nytimes/covid-19-data.
#
# The charts that you might have seen in the New York Times 
# are created from this data: 
#      https://www.nytimes.com/interactive/2021/us/covid-cases.html 
#
# PAUSE        It is remarkable that we have access to this
#   &          data. Please pause and consider what this data 
# THINK        represents and its importance.
#
## 3.0 Instructions ----
# There are two kinds of prompts: 
#
#    Coding prompts:      Write the necessary code to compute the answer. 
#                         For grading, it is important that you store your
#                         answers in the variable names listed with each 
#                         question in `backticks`. Please make sure to store
#                         the appropriate variable type (e.g., 
#                         a string, a vector, a dataframe, etc.).
#
#    Reflection prompts:  For each prompt marked `REFLECTION`, please write
#                         a response in your `README.md` file.
#
#    *Note 1:* Unless otherwise stated, use DPLYR functions to solve all coding prompts.
#    *Note 2:* Grading guidelines are here: https://canvas.uw.edu/courses/1616427/pages/info-general-grading-guidelines-and-rubrics
#
## 4.0 Getting Started ----
# Some of the coding prompts are difficult. If you get stuck, here are some 
# suggestions: 
#     1. Work slowly and systematically. Try to break the problem into small 
#        parts and tackle the parts, one by one. 
#     2. Clear the RStudio environment variables frequently. Check that 
#        variables contain exactly the data you expect. It is good practice 
#        to source your code from the beginning of the file. 
#     3. Go to the textbook and study the basics - complete the lecture 
#        exercises.
#     4. Search and read the DPLYR documentation here: 
#        - DPLYR API documents : https://dplyr.tidyverse.org/reference/index.html
#        - DPLYR cheatsheet    : https://github.com/rstudio/cheatsheets/blob/main/data-transformation.pdf
#     5. Post a message on Teams and/or ask for help from your TA
#     6. Do a Google search.
#
#  As always, if something is unclear please ask a Teaching Assistant.

#                                         Note 02.
# 1 Loading data ----
#
# You'll load data at the national, state, and county level. As you move
# through the assignment, you'll need to consider the appropriate data to 
# answer each question. 
#
# *Note 1:* To load the data you will need to get the "raw URLs" from the New 
# York Times GitHub page: https://github.com/nytimes/covid-19-data/
#
# *Note 2:* This command will clear your environment variables, which is helpful for keeping 
# your work tidy and for debugging. You will find bugs more more quickly 
# if you study your environment variables and re-fresh frequently.
#    rm(list = ls())

#                                         Note 03.
#     Load the tidyverse package.

library("tidyverse")

# 1a: Load the *national level* data into a variable. (Variable: `national`)

national <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv")

View(national)

# 1b: Load the *state level* data into a variable. (Variable: `states`)

states <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

View(states)

# 1c: Load the *county level* data into a variable. (NOTE: (a) This is a large
#    file. It may take 30-60 seconds to load. (b) As you work on this assignment, 
#    you might temporarily reduce the number of rows read into this variable with the 
#    parameter `nrows` -- see ?read.csv()) (Variable: `counties`)

counties <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

View(counties)


#                                         Note 04.
# *BEST PRACTICE:* Once you have loaded the dataset, it is a good practice to
# examine it with the View() command.
#
# *R1a: REFLECTION:* Use View() to open the three dataframes and explore 
#  the data, and with documentation form the New York Times*, answer 
#  these questions: 
#     (a) How does the County-level data differ from the 
#         the State-level and U.S. National-level? 
#     (b) What is the same about these three datasets? 
#     (c) What does the feature "fips" mean? Do a Google search and/or
#         visit: https://www.census.gov/library/reference/code-lists/ansi.htm0l
#
# * https://www.nytimes.com/interactive/2021/us/covid-cases.html 
#

#                                         Note 05.
#     How many observations (rows or records) and how many features (columns or
#     variables) are in each dataset? Next, you will answer these questions for the
#     dataset.

# 1d: How many observations are in `national`? (Variable: `num_obs_national`)

num_obs_national <- nrow(national)

paste0("There are ",
       num_obs_national,
       " observations in `national`.") %>% 
  print()


# 1e: How many observations are in `states`? (Variable: `num_obs_states`)

num_obs_states <- nrow(states)

paste0("There are ",
       num_obs_states,
       " observations in `states`.") %>% 
  print()


# 1f: How many observations are in `counties`? (Variable: `num_obs_counties`)

num_obs_counties <- nrow(counties)

paste0("There are ",
       num_obs_counties,
       " observations in `counties`.") %>% 
  print()


# 1g: How many features are in `national`? (Variable: `num_features_national`)

num_features_national <- ncol(national)

paste0("There are ",
       num_features_national,
       " features in `national`.") %>% 
  print()


# 1h: How many features are in `states`? (Variable: `num_features_states`)

num_features_states <- ncol(states)

paste0("There are ",
       num_features_states,
       " features in `states`.") %>% 
  print()


# 1i: How many features are in `counties`? (Variable: `num_features_counties`)

num_features_counties <- ncol(counties)

paste0("There are ",
       num_features_counties,
       " features in `counties`.") %>% 
  print()



#                                         Note 06.
# 2 Exploratory Analysis ----
#
# Use functions from the DPLYR package to explore the datasets by answering
# the following questions. Note: Please return the specific data being 
# asked about. Often, you do this with the pull() function. For example: 
#
#       What is the earliest date in the national-level dataset? `earliest_date`
#       
#       This code is CORRECT because pull() is used to return a single value:
#       earliest_date <- national %>%
#           filter(date == min(date)) %>%
#           pull(date)
#
#       This is NOT correct because an entire row is returned
#       earliest_date <- national %>%
#           filter(date == min(date))
#
# SUGGESTION: Uncomment the code and try out these two dplyr expressions.
#             Examine the data that is being returned.
#
# NOTE: Unless otherwise stated, use DPLYR functions to solve all coding 
#       tasks.

# 2a: How many total cases have there been in the U.S. by the most recent date
#    in the dataset? `total_us_cases` (Variable: `total_us_cases`)

most_recent_date <- national %>%
  filter(date == max(date)) %>%
  pull(date)

total_us_cases <- national %>%
  filter(date == max(date)) %>%
  pull(cases)

paste0("By the most recent count, on ",
       most_recent_date,
       ", there were ",
       prettyNum(total_us_cases, big.mark = ","),
       " total cases of Covid-19 in the U.S.") %>% 
  print()


# 2b: How many total deaths have there been in the U.S. by the most recent date
#    in the dataset? `total_us_deaths` (Variable: `total_us_deaths`)

total_us_deaths <- national %>%
  filter(date == max(date)) %>%
  pull(deaths)

paste0("By the most recent count, on ",
       most_recent_date,
       ", there were ",
       prettyNum(total_us_deaths, big.mark = ","),
       " total deaths from Covid-19 in the U.S.") %>% 
  print()


# 2c: Which state has had the highest number of cases?
#    `state_highest_cases` (Variable: `state_highest_cases`)

state_highest_cases <- states %>% 
  group_by(state) %>% 
  summarize(state_max = max(cases, na.rm = TRUE)) %>%
  filter(state_max == max(state_max, na.rm = TRUE)) %>% 
  pull(state)

paste0("The state with the highest number of cases is ",
       state_highest_cases,
       ".") %>% 
  print()


# 2d: What is the highest number of cases in a state?
#    `num_highest_state` (Variable: `num_highest_state`)

num_highest_state <- states %>% 
  group_by(state) %>% 
  summarize(state_max = max(cases, na.rm = TRUE)) %>%
  filter(state_max == max(state_max, na.rm = TRUE)) %>% 
  pull(state_max)

paste0("The highest number of cases in a state is ",
       prettyNum(num_highest_state, big.mark = ","),
       ".") %>% 
  print()


# 2e: Which state has the highest ratio of deaths to cases (deaths/cases), 
#    as of the most recent date? HINT: You may need to create a new column in 
#    order to do this. `state_highest_ratio` (Variable: `state_highest_ratio`)

deaths_to_cases_states_most_recent_df <- states %>%
  group_by(state) %>% 
  filter(date == max(date, na.rm = TRUE)) %>% 
  mutate(deaths_to_cases = deaths / cases)

View(deaths_to_cases_states_most_recent_df)

state_highest_ratio <- deaths_to_cases_states_most_recent_df %>%
  ungroup() %>% 
  filter(deaths_to_cases == max(deaths_to_cases, na.rm = TRUE)) %>% 
  pull(state)

paste0("The state with the highest ratio of deaths to cases is ",
       state_highest_ratio,
       ".") %>% 
  print()


# 2f: Which state has had the fewest number of cases *as of the most 
#    recent date*? HINT: This is a little trickier to calculate than the 
#    maximum because of the meaning of the row. `state_lowest_cases` (Variable: `state_lowest_cases`)

cases_states_most_recent_df <- states %>%
  group_by(state) %>% 
  filter(date == max(date, na.rm = TRUE))

View(cases_states_most_recent_df)

state_lowest_cases <- cases_states_most_recent_df %>%
  ungroup() %>% 
  filter(cases == min(cases, na.rm = TRUE)) %>% 
  pull(state)

paste0("The `state` with the fewest number of cases as of the most recent date is ",
       state_lowest_cases,
       ". This finding is based on grouping US territories and districts as 'states.'") %>% 
  print()


#                                         Note 07.
#     *R2a: REFLECTION:* What did you learn about the dataset when you calculated
#     the state with the lowest cases; What does that tell you about 
#     testing your assumptions in a dataset? Please comment.
#      
#     REMINDER: Please answer in the README.md.

# 2g: Which county has had the highest number of cases?
#    `county_highest_cases` (Variable: `county_highest_cases`)

max_cases_counties_df <- counties %>%
  filter(cases == max(cases, na.rm = TRUE))

View(max_cases_counties_df)

county_name_highest_cases <- max_cases_counties_df %>%
  pull(county)

county_highest_cases_state <- max_cases_counties_df %>%
  pull(state)

county_highest_cases <- paste0(county_name_highest_cases,
                               " County, ",
                               county_highest_cases_state
                               )

paste0("The county with the highest all-time highest number of cases is ",
       county_highest_cases,
       ".") %>% 
  print()


# 2h: #  What is the highest number of cases that have happened in a single county?
#   # `num_highest_cases_county` (Variable: `num_highest_cases_county`)

num_highest_cases_county <- max_cases_counties_df %>%
  pull(cases)

paste0("The all-time highest number of cases that have happened in a single county is ",
       prettyNum(num_highest_cases_county, big.mark = ","),
       " case(s).") %>% 
  print()


# 2i: Because there are multiple counties with the same name across states, it
#    will be helpful to have a column that stores the county and state together, 
#    in this form: "COUNTY, STATE". Therefore, add a new column to your `counties` 
#    dataframe called `location` that stores the county and state (separated by 
#    a comma and space). You can do this in at least two ways:
#      (1) `mutate()`   and the `paste0()` string function; or
#      (2) `unite()`  - see https://tidyr.tidyverse.org/reference/unite.html 
#          (Note: Be sure to keep the original columns.
#                 To do so, use the parameter `remove=FALSE`.) (Variable: `counties`)



# The form "County, State" is not very geographically correct to use in this
# case because it reads more as the name of a city in the given state, since
# that is how cities and municipalities are listed. For instance, reading the
# number of cases or deaths in "Snohomish, Washington" for a given date would
# lead one to believe they are reading about the city of Snohomish east of
# Everett, Washington. Instead, it is more appropriate to list them in the form
# "[County] County, [State]". For the example, reading "Snohomish
# County, Washington" is perfectly clear that the county, and not the city with
# the same name, is being referenced. I have alternately and intentionally
# opted for this more correct form of data. Answers for further prompts will be
# affected by this intentional decision.

counties <- counties %>%
  mutate(location = paste0(county,
                           " County, ",
                           state))

View(counties)

# 2j: What is the name of the location (county, state) with the highest number
#    of deaths? `location_most_deaths` (Variable: `location_most_deaths`)


# See my comment for coding response 2i regarding the format of the `locations`
# column.

location_most_deaths <- counties %>%
  filter(deaths == max(deaths, na.rm = TRUE)) %>%
  pull(location)

paste0("The location with the all-time highest number of deaths is ",
       location_most_deaths,
       ".") %>% 
  print()


#                                         Note 08.
#     *R2b: REFLECTION:* Is the location with the highest number of cases the 
#     location with the most deaths? If not, why do you believe that may be 
#     the case?

#                                         Note 09.
#     NOTE: As you have seen, the three datasets are "cumulative sums," that is,
#     running totals of the number of cases and deaths. On each day the case and
#     death counts either stay the same or increase. They should never decrease.
#     However, it is often very helpful to know by how much the numbers have
#     increased (if at all) between successive times.






# Correction to Note 09.: The New York Times clearly states in their FAQ that
# it is very possible for the cumulative sum case count and cumulative sum death
# count can very well go down for a number of reasons, from cause of death being
# reassigned to the county of residence and county of death for a victim of
# Covid-19 being different.





# 2k: Add a new column to your `national` dataframe called `new_cases`; that is, 
#    the number new cases each day.
#    HINTS:
#       1) Recall that the dyplr mutate() function is used to add new columns.
#       2) The dyplr lag() function will be very helpful. Search "R dplyr lag()" 
#           on Google and look for a good link. (Variable: `national`)

national <- national %>%
  mutate(new_cases = cases - lag(cases))

View(national)


# 2l: Similarly, the `deaths` columns *is not* the number of new deaths per day.
#    Add  a new column to the `national` dataframe called `new_deaths`
#    that has the number of *new* deaths each day. (Variable: `national`)

national <- national %>%
  mutate(new_deaths = deaths - lag(deaths))

View(national)


# 2m: What was the date when the most new cases occurred? (Variable: `date_most_cases`)

date_most_cases <- national %>% 
  filter(new_cases == max(new_cases, na.rm = TRUE)) %>%
  pull(date)

paste0("The date when the most new cases occurred is ",
       date_most_cases,
       ".") %>% 
  print()



# 2n: What was the date when the most new deaths occurred? (Variable: `date_most_deaths`)

date_most_deaths <- national %>% 
  filter(new_deaths == max(new_deaths, na.rm = TRUE)) %>%
  pull(date)

paste0("The date when the most new deaths occurred is ",
       date_most_deaths,
       ".") %>% 
  print()


# 2o: How many people died on the date when the most deaths occurred? (Variable: `most_deaths`)

most_deaths <- national %>% 
  filter(new_deaths == max(new_deaths, na.rm = TRUE)) %>%
  pull(new_deaths)

paste0(prettyNum(most_deaths, big.mark = ","),
       " people died on the date when the most deaths occurred.") %>% 
  print()


# 2p: Create a very basic plot by passing `national$new_cases` column to the
#    `plot()` function. Store the result in a variable `new_cases_plot`. (Variable: `new_cases_plot`)

new_cases_plot <- plot(national$new_cases)


# 2q: Create a (very basic) plot by passing the `new_deaths` column to the
#    `plot()` function. Store the result in a variable `new_deaths_plot`. (Variable: `new_deaths_plot`)

new_deaths_plot <- plot(national$new_deaths)


#                                         Note 10.
#
# INTERLUDE - This is for your own exploration - Have fun!
#
# The plots you just created are rudimentary. As you have seen, 
# the charts in the New York Times are more refined. See: 
# https://www.nytimes.com/interactive/2021/us/covid-cases.html 
#
# We have developed a chart that demonstrates that you too will
# soon be able to create insightful and beautiful charts. 
#
# To get started you will first need load these functions, 
# with the source function: 


# Getting multiple errors for sourcing github path to `rolling_windows.R`. Same
#error,respectively, for paths that include ...`a3-baronk2/blob/main/rolling_windows.R`
# (the link as it appears to work on a browser), and ...`a3-baronk2/rolling_windows.R`
# (the link as I would intuitively think of it as working).

# Error in file(filename, "r", encoding = encoding) :
#   cannot open the connection to 'https://github.com/info201b-au2022/a3-baronk2/main/rolling_windows.R'
# In addition: Warning message:
#   In file(filename, "r", encoding = encoding) :
#   cannot open URL 'https://github.com/info201b-au2022/a3-baronk2/main/rolling_windows.R': HTTP status was '404 Not Found'

# source("https://github.com/info201b-au2022/a3-baronk2/main/rolling_windows.R")


source("C:/Users/Owner/Documents/Kevin/School/University_Of_Washington/Informatics/2022-2023/Autumn_2022/Info_201/info201/assignments/a3-baronk2/rolling_windows.R")


# Next, run this code several times, changing the window size. 
# Suggestions for window sizes: 1, 3, 7, 20, 50, 200. You
# should see the charts in the RStudio "Plots" tab.
#

window_size <- 7
national <- moving_avg_counts(national, window_size)
moving_avg_cases_plot <- plot_moving_avg_cases(national, window_size)
print(moving_avg_cases_plot)

#
# This chart would NOT be possible without the data wrangling 
# that you did in part 2.0!!  (If the chart does not appear, 
# please contact your TA.)
#
# If you like, review the two functions: moving_avg_counts() and 
# plot_moving_avg_cases() in the file `A3-functions.R`. 
#
# Take note that you have the foundation coding knowledge 
# to do this kind of work, and much more!

#                                         Note 11.
# 3. Grouped Analysis -----
#
# An incredible power of R is to perform the same computation *simultaneously*
# across groups of rows. As you know, this capability is called aggregation. 
# It relies on the group_by() and summarize() functions in dplyr. 
#
# For more on summarize, see: https://dplyr.tidyverse.org/index.html
# For more on group_by() see: https://dplyr.tidyverse.org/articles/grouping.html?q=group%20_%20by#group_by

# 3a: What is the county with the *current* highest number of cases in each state? 
#    *Current* means the the most recent date. Your answer, stored in
#    `highest_in_each_state`, should be a *vector* of  `location` names, that is, 
#    the column with COUNTY, STATE.  HINT: Be careful about the order of filtering 
#    your data. (Variable: `highest_in_each_state`)

highest_in_each_state <- counties %>% 
  group_by(location) %>%
  filter(date == max(date, na.rm = TRUE)) %>% 
  group_by(state) %>% 
  filter(cases == max(cases, na.rm = TRUE)) %>% 
  summarize(max_location = location) %>% 
  .[["max_location"]]

is.vector(highest_in_each_state)

highest_in_each_state

# If `highest_in_each_state` is a vector, `View()` should not display it well.

# View(highest_in_each_state)


# 3b: Using the variable `highest_in_each_state`, which location (COUNTY, STATE) has had
#    the highest number of cases in Washington? (Hint: Use the function str_detect() from
#    the stringr() package.) (Variable: `highest_in_wa`)

highest_in_wa <- data.frame(highest_in_each_state = highest_in_each_state,
                            is_washington = highest_in_each_state %>%
                              str_detect(", Washington")) %>% 
  filter(is_washington) %>% 
  pull(highest_in_each_state)

paste0("The location with the highest number of cases *currently* in Washington,",
       " since that is what `highest_in_each_state` calculates, rather than",
       " the location that *has had* the highest number of cases in Washington",
       " which coding prompt 3b implies with the grammar of its question, is ",
       highest_in_wa,
       ".") %>% 
  print()

# 3c: What is the county with the *current* (e.g., on the most recent date) lowest
#    number of deaths in each state? Your answer, stored in lowest_in_each_state`,
#    should be a *vector* of location` names (the column with COUNTY, STATE). (Variable: `lowest_in_each_state`)


# Multiple counties in the same state in the output result from ties for lowest
# number of deaths in each county, often at a value of 0.

lowest_in_each_state <- counties %>% 
  group_by(location) %>%
  filter(date == max(date, na.rm = TRUE)) %>% 
  group_by(state) %>% 
  filter(deaths == min(deaths, na.rm = TRUE)) %>% 
  summarize(deaths, location) %>% 
  .[["location"]]

is.vector(lowest_in_each_state)

lowest_in_each_state

# If `lowest_in_each_state` is a vector, `View()` should not display it well.

# View(lowest_in_each_state)


#                                         Note 12.
#     *R3a: REFLECTION:* Why are there so many observations (counties) in the 
#     variable `lowest_in_each_state`? That is, wouldn't you expect 
#     the number to be around 50?

# 3d: What *proportion* of counties have had zero deaths in each state? 
#    This is a very simple question. But, as is often the case, with data 
#    and code, it is actually quite complex. Consider that:  
#        prop =  ncz / T,   where ncz is the number of counties with zero deaths
#                           and T is the total number of counties. 
#    Given this, the goal is to return a *dataframe* with both the state name, 
#    and the proportion (`prop`) in a variable called `prop_no_deaths`
#    
#    There are several ways to tackle this question. This is a long but 
#    relatively straightforward approach: 
#       (1) Create a dataframe with two columns: `state` and `ncz`. 
#       (2) Create a second dataframe with two columns: `state` and `t`
#       (3) Join the two dataframes by `state` and add the `prop` column
#       (4) You will note that the dataframe from step 3 has a lot of NAs. 
#            Why? You can replace the NAs with `replace_na()`
#            See https://tidyr.tidyverse.org/reference/replace_na.html
#    
#     NOTE: As you work on steps (1) and (2) carefully consider how to group 
#     the data. (Variable: `prop_no_deaths`)


# "*Have had*" zero deaths implies ever having had zero deaths, but I will read
# the prompt as I believe the meaning is intended, as *currently* zero deaths.

ncz_df <- counties %>% 
  group_by(location) %>% 
  filter(date == max(date, na.rm = TRUE)) %>% 
  group_by(state) %>% 
  summarize(ncz = sum(deaths == 0, na.rm = TRUE))

View(ncz_df)

# Using `count` twice like this seems redundant, but I wasn't able to find
# another way to count the unique counties within each state without getting
# all the rows of observations representing different dates besides using the
# same technique used in the process for obtaining `ncz_df` of filtering by most
# recent date. The techniques from section 4 of using `n_distinct()` and
# `length(unique())` don't seem to be working either, probably because I was
# trying to use it on a group within a dataframe, rather than on a vector, which
# is the appropriate argument type for `n_distinct()`.

t_df <- counties %>% 
  count(state, county) %>% 
  count(state) %>%
  mutate(t = n) %>%
  select(-n)

View(t_df)

prop_no_deaths <- left_join(ncz_df,
                            t_df
                            ) %>% 
  mutate(prop = ncz / t)

View(prop_no_deaths)

# In response to Coding Prompt 3d(4), I don't have any `NA`s in my dataframe.
# Did I do something wrong? I feel like I did something right!



# 3e: Using the `prop_no_deaths` variable (3.d), what proportion of counties in 
#    Washington State have had zero deaths? `wa_prop_no_deaths` (Variable: `wa_prop_no_deaths`)

wa_prop_no_deaths <- prop_no_deaths %>% 
  filter(state == "Washington") %>% 
  pull(prop)

paste0("The proportion of counties in Washington State that have had zero",
       " deaths is ",
       wa_prop_no_deaths,
       ".") %>% 
  print()

#                                         Note 13.
# 4. Joins  ----
#
# As described at the New York Times GitHub page, collecting this 
# data has been a massive effort. Accordingly, there might be 
# mistakes in the data. After all, data is being collected 
# for more than 3,000 U.S. counties.  
#
# (Incidentally, to determine exactly how many counties are in your
# dataset you could use this command: 
#    n_distinct(counties$location) or
#    length(unique(counties$location))
# See: https://dplyr.tidyverse.org/reference/n_distinct.html) 
#
# One check for data consistency is the following: 
# 
#     On a given day (and, in turn, all days), the following is true: 
#         (a) All the County case counts for a State (`counties` dataframe) 
#             sum to the State case counts (`states`); and,
#         (b) The States case counts should sum to the National case counts 
#             (`national`).
#
# If (a) is false or (b) is false then something is wrong.
#
# A convenient way to test for this data consistency check is to create the
# following four-column dataframe (`all_totals`) and then compare the
# national, state, and county totals:
#
# all_totals: 
# date | national_total_cases | state_total_cases | county_total_cases 
#
# Column                Brief description 
# date:                 Day in the time series (all days in column)
# national_total_cases: The case counts in the `national` dataframe
# state_total_cases:    The sum of all case counts in the `states` dataframe
# county_total_cases:   The sum of all case counts in the `counties` dataframe
#
# We now guide you through the steps for this consistency check.

# 4a: Create a `county_by_day` dataframe with columns: `date` and
#    `county_total_cases`. HINT: To summarize the case counts, you will need to 
#    group the data. (Variable: `county_by_day`)

county_by_day <- counties %>% 
  group_by(date) %>% 
  summarize(county_total_cases = sum(cases, na.rm = TRUE))

View(county_by_day)


# 4b: Create a `state_by_day` dataframe with columns: `date` and
#    `state_total_cases`.  HINT: See previous hint. (Variable: `state_by_day`)

state_by_day<- states %>% 
  group_by(date) %>% 
  summarize(state_total_cases = sum(cases, na.rm = TRUE))

View(state_by_day)


# 4c: Join the `county_by_day` and `state_by_day` dataframes. Call this dataframe
#    `totals_by_day`. (Variable: `totals_by_day`)

totals_by_day <- left_join(county_by_day, state_by_day)

View(totals_by_day)

# 4d: Join `totals_by_day` with the `national` dataframe and, for clarity, rename
#    the `cases` column to `national_total_cases`. Call this dataframe
#    `all_totals`. (Variable: `all_totals`)

all_totals <- left_join(national, totals_by_day) %>% 
  rename(national_total_cases = cases)

View(all_totals)


#                                         Note 14.
#     Finally, with this convenient dataframe (`all_totals`), you can write code
#     to test the consistency check

# 4e: How many differences do you find between `national_total_cases` and 
#    `state_total_cases`? Use the pull() function assign a numeric 
#    value to `national_state_diff`. (Variable: `national_state_diff`)

national_state_diff <- all_totals %>% 
  summarize(nat_st_diff_col = sum(national_total_cases != state_total_cases,
                                  na.rm = TRUE)) %>% 
  pull(nat_st_diff_col)

paste0("There is/are ",
       national_state_diff,
       " difference(s) between `national_total_cases` and `state_total_cases`.")


# 4f: How many differences do you find between `state_total_cases` and 
#    `county_total_cases'? Use the pull() function assign a numeric 
#    value to `state_county_diff`. (Variable: `state_county_diff`)

state_county_diff <- all_totals %>% 
  summarize(st_co_diff_col = sum(state_total_cases != county_total_cases,
                                  na.rm = TRUE)) %>% 
  pull(st_co_diff_col)

paste0("There is/are ",
       state_county_diff,
       " difference(s) between `state_total_cases` and `county_total_cases`.")


#                                         Note 15.
#     *R4a: REFLECTION:* When the check was carried out on August 25, 2022
#      an inconsistency was found. (a) Given the work that you've just
#      completed (4.a - 4.f), what can you say about the source of the 
#      inconsistency? (b) What might be your next step to discover where 
#      exactly in the data the inconsistency lies? To answer questions
#      (a) and (b), consider exploring the dataframes that 
#      you have created in the above steps.

#                                         Note 16.
#     5. Independent exploration -----
#     
#     In sections 2-4, you were asked to find answers to questions about three
#     cumulative sum time series, of much importance for making sense of the past
#     and present and for shaping human action in the future. Now, it is your turn.
#     Ask your own question and then wrangle some data to answer your question.
#     Show that your code works. As appropriate, please comment your code so that
#     it is understandable.
#     
#     QUESTION:  Write your question for 5.a here:

#     Which states demonstrate inconsistency between `county_total_cases` and
#     `state_total_cases`after the point of divergence between those two
#     variables when summed together on to the national level?

states_cases_at_div <- states %>%
  filter(date == "2022-04-21" | date == "2022-04-22") %>% 
  arrange(state) %>%
  rename(state_total_cases = cases) %>% 
  select(date, state, state_total_cases)

View(states_cases_at_div)


counties_cases_at_div <- counties %>%
  group_by(date, state) %>% 
  summarize(county_total_cases = sum(cases, na.rm = TRUE)) %>% 
  filter(date == "2022-04-21" | date == "2022-04-22") %>% 
  arrange(state) %>%
  select(date, state, county_total_cases)

View(counties_cases_at_div)


st_co_cases_at_div <- left_join(states_cases_at_div,
                                counties_cases_at_div
                                ) %>% 
  mutate(st_co_differ = state_total_cases != county_total_cases)

View(st_co_cases_at_div)

st_co_cases_differ_at_div <- st_co_cases_at_div %>% 
  filter(st_co_differ)

View(st_co_cases_differ_at_div)

paste0("The state(s) which demonstrate(s) inconsistency between",
       " `county_total_cases` and `state_total_cases`after the point of",
       " divergence between those two variables when summed together on to the",
       " national level is/are ",
       pull(st_co_cases_differ_at_div, state),
       ".") %>% 
  print()
