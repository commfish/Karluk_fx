# notes ----
# forecasting using timeseries
# sarah.power@alaska.gov
# 11/14/2018

# load ----
library(fpp2)
library(ggplot2)
library(tidyverse)
library(RDS)
library(here)
options(scipen=999)

# data ----

karluk2018 <- read.csv('data/karluksmoothing.csv') 
karluk <- as.ts(karluk2018)
karluk2018 <- read.csv('data/karluk.csv') 
ker <- as.ts(karluk2018$ker)
klr <- as.ts(karluk2018$klr)
ktr <- as.ts(karluk2018$ktr)

#choose one
karluk <- ker
karluk <- klr
karluk <- ktr

# analysis ----
autoplot(karluk)
ggAcf(karluk)
ggAcf(diff(karluk))
fc <- fch <- holt(y = karluk, h = 5,  exponential = TRUE) 
fc <- fcn <- naive(karluk, h = 5)
fc <- fcses <- ses(karluk, h = 5)
summary(fc)
checkresiduals(fc)
#accuracy(fc)
autoplot(fc) + autolayer(fitted(fc))
