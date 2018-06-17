# London Rental House Prediction

Supervised learning of 1-bedroom/studio rents from London location

<p align="center">
  <img width="1000" src="https://github.com/mlaskowski17/London-rental-house-prediction/blob/master/images/rental2.png">
</p>


## General Overview

You have been provided with a dataset that contains thousands of rental prices (pcm) for single bedroom properties in London along with corresponding Lat/Long coordinates. This is a real dataset collected using automated scripts from online sources, thus there may be a number of properties that are not located within Greater London and data clean up is needed. Also provided is a set of coordinates for all stations on the London Underground network. The aim of this task was to use supervised learning techniques (in this case Majority Bins) to learn from the supplied sample data the mapping from geographical location, specified as two-dimensional vector x = [latitude longitude], to rental costs per calendar month y = [GBP], i.e. identify the unkown f(x) = y.

Thus, for an arbitrary location in Greater London we want to know the predicted rental price from your machine learning system. Following approach is without using specialist toolboxes or external code.


## Files
