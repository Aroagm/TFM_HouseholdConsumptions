# TFM_HouseholdConsumptions
A brief overview of the project can be found [here](https://aroagm.github.io/) but this document contains more detailed information on the data usage, methodology and results.

[1. Introduction](#1._Introduction) <br>
[2. Input Data](#2._Input_Data) <br>
[3. Methodology](#3._Methodology) <br>
[4. Results and conclusions](#4._Results_and_conclusions)

## 1. Introduction
The purpose of this project is to apply all the techniques and skills acquired during the Data Science Master from Kschool.  
The chosen topic to work on is energy, in particular I decided to use household consumption data. With this data the goal is to develop a tool that helps the energy audit of some of the electrical household appliances.

An analyses is carried out with hourly energy prices to obtained clusters to categorize the hours with its corresponding prices. With that analysis the household data is manipulated to generate a dataframe with savings if the hour of use of the electrical appliance is change to the previous or next hour. In summary the output is a recommendation of slight changes in periods to use certain electrical household appliances.

#### Files and ordered of usage
The repository contains all the files to performace the analysis, first the Prices_data has to be execute, then the Household_data and finally the Code for the Shiny app is in the TFM folder.


## 2. Input Data

There are two datasets used for the project: household consumptions and  prices. 

#### Household consumptions

The household consumptions dataset had been obtained from https://data.open-power-system-data.org/household_data/. The data package is part of a european project related to microgrids(CoSSMic) and contains measured time series data for 11 households in southern Germany relevant for household- or low-voltage-level power system modeling. 

The details for all the data package can be found in the link at the begginnig of the paragraph but same relevant characteristics are going to be explained. First the selected data is the hourly data, it contains all the information for the houses in columns. The columns have a naming pattern as follows: DE_KN_household_consumptionconcept, for example for the residential house 3 the consumption of the refrigerator would be in the column DE_KN_residential3_refrigerator. 

This household data consumptions are aggregated, unit kWh. The time period under study is year 2016 because it is the only whole year of data. 

#### Prices

Since the data is from german households the energy prices have to be obtain from the german system operator: entso https://transparency.entsoe.eu/. The file was downloaded for the year 2016 and include in the repository, Day-ahead Prices_201601010000-201701010000.csv. 

There are some negatives values for prices due to high renewables generation, to learn more go to this [link](https://www.cleanenergywire.org/factsheets/why-power-prices-turn-negative).

Another consideration is that when the prices are used to calculate savings they are multiply by a factor of 2 since the taxes are not included in the hourly energy data market. This factor has been stablish based on the spanish market, nowadays the differences between the market price and the consumer price can be seen in the system operator website ()

The prices are group in clusters using kMeans, it was inspired by this article http://eps.upo.es/martinez/papers/ICREPQ07_martinez-alvarez.pdf

## 3. Methodology
This is the final project for the Kschool Data Science Master so to I decided to work with different coding languages to practise as much as possible. The tools I have used are:

1. Jupyter notebooks (launch Jupyter with Anaconda)
2. RStudio to build the Shiny app.
3. Github, github pages and shinyapps. io to publish the code and developments
4. Pingendo to build the web visualisation
5. Tableau is secondary since nothing is included in this project but it was very useful while inspecting and cleaning the data, as a complement to jupyter to visualize in an simple way 



## 4. Results and conclusions
The results of the project are visualised in the [shiny app](https://aroagm.shinyapps.io/Household_consum/). The usage is very intuitive:

 1. Select a house and one of the electrical appliances to visualise the consumption during the year

 2. Select an hour to give recommendations about the usage and the estimation of savings.

One consideration is that for some houses the data results from the analyses are not very consistent since the consumption for the electrical appliances selected along the year is abnormally low.
