# TFM_HouseholdConsumptions
A brief overview of the project can be found [here](https://aroagm.github.io/) but this document contains more detailed information on the data usage, methodology and results.

[1. Introduction](#1._Introduction) <br>
[2. Input Data](#2._Input_Data) <br>
[3. Methodology](#3._Methodology) <br>
[4. Results and conclusions](#4._Results_and_conclusions)

## 1. Introduction
The purpose of this project is to apply all the techniques and skills acquired during the Data Science Master from Kschool.  
The chosen topic to work on is energy, in particular I decided to use household consumption data. With this data the goal is to develop a tool that helps the energy audit of some of the electrical household appliances.

An analyses is carried out with hourly energy prices to obtained 

The output is a recommendation of slight changes in periods to use certain electrical household appliances.

## 2. Input Data
There are two datasets used for the project: household consumptions and  prices. 

The household consumptions dataset had been obtained from https://data.open-power-system-data.org/household_data/. The data package is part of a european project related to microgrids(CoSSMic) and contains measured time series data for 11 households in southern Germany relevant for household- or low-voltage-level power system modeling. The details for all the data package can be found in the link at the begginnig of the paragraph but same relevant characteristics are going to be explained. First the selected data is the hourly data, it contains all the information for the houses in columns. The columns have a naming pattern as follows: DE_KN_household_consumptionconcept, for example for the residential house 3 the consumption of the refrigerator would be in the column DE_KN_residential3_refrigerator.






http://eps.upo.es/martinez/papers/ICREPQ07_martinez-alvarez.pdf
<br>
also check the https://ec.europa.eu/eurostat/statistics-explained/index.php?title=File:Electricity_prices,_First_semester_of_2016-2018_(EUR_per_kWh).png
Based on the spanish market a correction factor will be used. Nowadays the differences between the market price and the consumer price can be seen in the system operator website:
## 3. Methodology
This is the final project for the Kschool Data Science Master so to I decided to work with different languages to practise as much as possible. This is the main reason for 

For price the number is double in household_data

Select year 2016 which is a complete year of data. Also only the 
## 4. Results and conclusions
The results of the project are visualised in the [shiny app](https://aroagm.shinyapps.io/Household_consum/). The usage is very intuitive:

 1. Select a house and one of the electrical appliances to visualise the consumption during the year

 2. Select an hour to give recommendations about the usage and the estimation of savings.

One consideration is that for some houses the data results from the analyses are not very consistent since the consumption for the electrical appliances selected along the year is abnormally low.
