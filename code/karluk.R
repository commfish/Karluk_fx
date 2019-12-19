# notes ----
# forecasting using timeseries
# sarah.power@alaska.gov
# 2019

# load ----
if(!require("tidyverse"))   install.packages("tidyverse") # data manipulation & graphing
if(!require("RDS"))   install.packages("RDS") # forecasting
if(!require("fpp2"))   install.packages("fpp2") # forecasting
options(scipen=999) # prevent scientific notation everywhere

# data ----

karluk2018 <- read.csv('data/karluk.csv') 
# run = return to a river as determined by harvest and escapement estimates
# ker = karluk early run
# klr = karluk late run
# ktr = karlut total run = early + late

# create timeseries object
ker <- as.ts(karluk2018$ker)
klr <- as.ts(karluk2018$klr)
ktr <- as.ts(karluk2018$ktr)

#choose one set of data to do analysis on:
karluk <- ker
karluk <- klr
karluk <- ktr

# analysis ----
autoplot(karluk)
ggAcf(karluk)
ggAcf(diff(karluk))

# choose one type of timeseries forecast to run
fc <- fch <- holt(y = karluk, h = 1,  exponential = TRUE) 
fc <- fcn <- naive(karluk, h = 1)
fc <- fcses <- ses(karluk, h = 1)

# for checking and comparison
summary(fc)
checkresiduals(fc)
accuracy(fc)

#plot ----
autoplot(fc) + autolayer(fitted(fc))
