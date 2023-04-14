# A3: U.S. COVID Trends

## 1. Overview
In many ways, we have come to understand the gravity and trends in the COVID-19 pandemic through quantitative means. Regardless of media source, people are consuming more epidemiological information than ever, primarily through reported figures, charts, and maps.

This assignment is your opportunity to work directly with the same data used by the _New York Times_. While the analysis is guided through a series of questions, it is your opportunity to use programming skills to ask more detailed questions about the pandemic.

You'll load the data directly from the [New York Times GitHub page](https://github.com/nytimes/covid-19-data/), and you should make sure to read through their documentation to understand the meaning of the datasets.

## 2. Critical Analysis & Reflection: Before You Code
As you know, the first step in a data science project is to investigate the domain. Accordingly, please begin this assignment by carefully reviewing [New York Times GitHub page](https://github.com/nytimes/covid-19-data/) and
reading this [FAQ](https://www.nytimes.com/interactive/2020/us/about-coronavirus-data-maps.html) about the data. Working with _Data Feminism_ (Catherine D'Ignazio and Lauren Klein, 2020) and the _Envisioning Cards_, consider the following questions:
* What is the _New York Times_' goal?
* Where does the data come from? Is the data reliable?
* Who are the direct and indirect stakeholders?
* What values are implicated by this dataset and system?
* What issues related to "power" arise because of this dataset?

After reading and considering these questions, please provide written responses to these two questions:
* **R0a** Drawing on _Data Feminism_, the _Envisioning Cards_, and your study of the data, describe and discuss the _New York Times_' project. Discuss the social aspects of this project, focusing on stakeholders, values, and power.
* **R0b** Review the visualizations that are found at the bottom of this [FAQ](https://www.nytimes.com/interactive/2020/us/about-coronavirus-data-maps.html). Document two _important_ questions that a person living in the U.S. could answer with these visualizations. Discuss the importance of these questions.

Note: Please write your answers below under the heading "Your Responses and Reflections."

## 3. Coding and Critical Analysis & Reflect: While You Code

### Getting Started
You should start this assignment by opening up the `analysis.R` script. The script will guide you through an initial analysis of the data.

You will also find a file, named `rolling_windows.R`. Studing the code in the file will be helpful for some aspects of this assignment.

* **Coding prompts.** Complete the coding prompts in `analysis.R`.  Your goal is correct code that is readily understandable.
* **Reflection prompts.** Throughout the script, there are prompts labeled `REFLECTION`. Please write 1-3 sentences for each of these prompts below. Please strive for concise, clear, inclusive, and insightful writing. As appropriate, your writing should:
   - Provide evidence (e.g., facts from the datasets, points from the New York Times documentation, etc.)
   - Give justification for your opinions
   - Genuinely reflect on your views.  

## 3. Critical Analysis & Reflection: After You Code
**R6a** Consider the many visualizations that can be created with this data set (see [FAQ](https://www.nytimes.com/interactive/2020/us/about-coronavirus-data-maps.html)) for many examples, which in the next few weeks,
you will be able to create. Also, step back and reflect on the hard work that you have completed.

Now, drawing on _Data Feminism_ and/or the _Envisioning Cards_, comment on the importance of this data set.

**R6b** Please briefly comment on one of these or similar questions:
* What, if anything, made you curious?
* What, if anything, surprised you about your R coding work?
* What might you do the same or differently on your next data wrangling project?

## Reflection Prompts

**R0:** Critical Analysis & Reflection: Before You Code
* **R0a**

The direct stakeholders for the Covid-19 data project are those who have personally experienced a case or death from Covid-19, their family members and friends, the hospitals and other health agencies reporting the data that the New York Times is collecting, and the hospital workers themselves taking in the cases, diagnosing, determining cause of death, etc. Indirect stakeholders would include other journalism organizations who might benefit from the data availability by being able to write their own news stories referencing it, policymakers who may vote for resource allocation based on the data, and health official organizations such as the CDC who can use the data to determine severity of the epidemic on local, statewide, and countrywide scales.

Not only does the project value the human lives it may be able to save by way of those indirect stakeholders being able to make change using the information provided in the data, it honors those who have died by counting them, and similarly honors those who have gone through Covid-19 contraction, by counting their cases as well. It also values transparency regarding how the data was collected, which sheds light onto how the problem of counting what superficially would seem like simple numbers is perhaps less simple than one might initially think.

As far as power, The New York Times is at the mercy of all the hospital systems, counties, and states regarding how the data is recorded. NYT has done its best to qualify and explain these nuances to expose where the power lies in data collection.


* **R0b**:
   - Question 1: To what extent is Covid-19 responsible for the greater than normal number of deaths?

This question is important because it is critical to know just how much Covid-19 is affecting the lives, and in this case, deaths, of so many people, compared to other factors, such as the flu, injuries, natural causes of death, and others. It is vital to know how the issue at hand fits into the larger puzzle, so that the data can be understood more fully as it is taken in, either from data visualizations or from viewing the data directly. One of the biggest problems with Covid-19 is that it is so anomalously responsible for such an excess of deaths across the nation.


   - Question 2: Which countries had the most deviation from normal number of deaths for a given year because of Covid-19?

As the answer to this question is gleaned from the data and visualizations of the data, patterns may emerge. Are all of the countries being affected the most in the Northern hemisphere or in the Southern hemisphere? Are they in the East or are they in the West? The patterns may be as enlightening as the initial answers. For example, if all of the countries with the most deviant excess deaths are known for tightly packed metropolitan areas, that could explain a lot about how the virus spreads and could point in the direction of a potential solution, such as comprehensive mask-wearing requirements.


**R1:** Loading Data
* **R1a**:
(a) * far more data, since there are more counties
    * `fips` column, which `states` also contains, but `national` does not
    * `county` and `state` columns to identify each county

(b) * `date`, `cases`, and `deaths` columns are the same
    * Date format is the same for all datasets

(c) According to [ESRI Technical Support](https://support.esri.com/en/technical-article/000002594):

> Question

> What are FIPS codes?

> Answer

> Federal Information Processing Standards (FIPS), now known as Federal Information Processing Series, are numeric codes assigned by the National Institute of Standards and Technology (NIST). Typically, FIPS codes deal with US states and counties. US states are identified by a 2-digit number, while US counties are identified by a 3-digit number. For example, a FIPS code of 06071, represents California -06 and San Bernardino County -071.


**R2**: Exploratory Analysis
* **R2a**: Finding that American Samoa was the “state” with the fewest cases made me go back to the column names in the original `states` dataset to see if all the states, territories, and districts were under the same category and what that category was called. Perhaps it would be helpful for parsing the data to have another column which lists the correct geographic term for each “state.”


* **R2b**: The location with the all-time highest number of cases is not the same as the county with the highest number of deaths. This is probably the case because of the different timelines that New York City County, New York, where there have been the most deaths, and Los Angeles County, California, where there have been the most cases, experienced respectively. New York City County had an earlier surge of Covid-19 cases, when the pandemic was in its earlier stages, and vaccines and treatment were unavailable or less available. This could have shocked the population into getting vaccinated when vaccines were available, leading to fewer cases later, whereas Los Angeles County may have had a surge in cases more recently after treatment and vaccination were more available and the high number of cases were more mild and less severe, leading to fewer deaths.




**R3**: Grouped Analysis
* **R3a**: Multiple counties in the same state in the output result from ties for lowest number of deaths in each county, often at a value of 0.


**R4**: Joins
* **R4.a**: (a)	The source of the inconsistency seems to have occurred on 2022-04-22. On 2022-04-21 and up until that point in time, the `county_total_cases` and the `state_total_cases` were matching. After then, those totals were mismatched until county data ceased after 2022-05-13.

(b)	My next step to discover where exactly in the data the inconsistency lies would be to perform a similar analysis by state to see which states are inconsistent and which ones are consistent at the date of divergence. I’m not sure with the depth of this data what any fact-checking step after that might look like.



**R5**: Independent Exploration
* No prompts




**R6**: Critical Analysis & Reflection: After You Code
* **R6a** This dataset is very important, not only because it can track summary information and running totals for different levels of geographic hierarchy, such as county, state, and nation, but could also be displayed as a map that changes over time, showing where and when the virus is most actively spreading.

It is also important because it sets a precedent for other nation around the world. They might, or journalists and journalistic organizations within them might say, “Hey, if the U.S. and the New York Times can perform that caliber of analysis, why can’t we?” This would get them starting to ask the more critical questions delving into the why of not being able to calculate these levels of statistics if they don’t have the infrastructure to get reliable and consistently reliable tallies, for example. On the flip side, they might realize, depending on the country, that they do in fact have the capability to run this kind of data. In fact, they might be able to do an even better or more organized job by critically viewing and analyzing the gaps or other errors or inconsistencies in this data series.


* **R6b**: As I was working on a prompt involving adding new columns to a dataframe, I did so out of the correct order. At the time, I had no internet connection with the power outage from the recent windstorm, so I couldn’t reload the data from the NYT github page and retry the prompts in the correct order.

Moving forward, I would tend to prefer working on copies of the originals, or references to them, so that if a similar case were to occur, I would be able to reload my alternate copy from the untouched original copy.
